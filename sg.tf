resource "aws_security_group" "app" {
  name = "application"
  description = "application security group"
  vpc_id = "${aws_vpc.default.id}"

  # Only application in
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]
  }

    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]
    }

    ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]
    }
    
  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "mydb1" {
  name = "mydb1"
  description = "RDS postgres servers (terraform-managed)"
  vpc_id = "${aws_vpc.default.id}"

  # Only postgres in
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = ["${aws_security_group.app.id}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb" {
  name = "alb"
  description = "alb security group"
  vpc_id = "${aws_vpc.default.id}"
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}