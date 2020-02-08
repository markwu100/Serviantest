resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = "ami-0af8225d3ab235ef6"
  instance_type = "t2.micro"
# Security Group
  key_name      = "${var.ssh_key_name}"
  security_groups = ["${aws_security_group.app.id}"]
#  load_balancers  = [aws_elb.main.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name                      = "servian-terraform-asg"
  max_size                  = "${var.asg_max}"
  min_size                  = "${var.asg_min}"
#  load_balancers            = ["${aws_lb.main.name}"]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.asg_desired}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier       = ["${aws_subnet.main.id}","${aws_subnet.main-1.id}"]
  target_group_arns         = ["${aws_alb_target_group.alb_target_group.arn}"]

  tag {
        key = "Name"
        value = "app-asg"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_attachment" "asg_attachment_main" {
  autoscaling_group_name = "${aws_autoscaling_group.main.id}"
  alb_target_group_arn   = "${aws_alb_target_group.alb_target_group.arn}"
}

