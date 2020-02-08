# Create a new load balancer
resource "aws_alb" "main" {
  name               = "servian-techtest-alb"
  internal           = false
  load_balancer_type = "application"
#  availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = ["${aws_subnet.main.id}","${aws_subnet.main-1.id}"]

  tags = {    
    Name    = "servian-techtest-alb"
  }   
}

resource "aws_alb_target_group" "alb_target_group" {  
  name     = "techtest-alb-tg"  
  port     = "3000"  
  protocol = "HTTP"  
  vpc_id   = "${aws_vpc.default.id}"   
  tags = {    
    name = "techtest-alb-tg"   
  }   

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
 #   path                = "${var.target_group_path}"    
    port                = "3000"  
  }
}
resource "aws_alb_listener" "alb_listener" {  
  load_balancer_arn = "${aws_alb.main.arn}"  
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"  
  }
}

resource "aws_alb_listener_rule" "listener_rule" {
  depends_on   = ["aws_alb_target_group.alb_target_group"]  
  listener_arn = "${aws_alb_listener.alb_listener.arn}"  
  priority     = "100"   
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"  
  }   
   condition {    
     #field  = "path-pattern"    
     #values = ["/*"]
     path_pattern {
        values = ["/*"]
      }  
   }
}
