resource "aws_vpc" "default" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy     = "default"
  tags = { 
    Name = "servian" 
    }
}

resource "aws_subnet" "main" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.source_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "${var.user_name}_Main"
  }
}

resource "aws_subnet" "main-1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.source_cidr_block1}"
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "${var.user_name}_Main_1"
  }
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "${var.user_name}_Private"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_cidr_block1}"
  map_public_ip_on_launch = false
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "${var.user_name}_Private_1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"
  tags = {
    Name = "${var.user_name}"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "main"
  }
}

resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.main.id}"]
  egress{
    protocol = "all"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "all"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags =  {
    Name = "acl-main"
  }
}

resource "aws_network_acl" "main-1" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.main-1.id}"]
  egress{
    protocol = "all"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "all"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags =  {
    Name = "acl-main1"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id = "${aws_subnet.main-1.id}"
  route_table_id = "${aws_route_table.r.id}"
}

