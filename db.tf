resource "aws_db_subnet_group" "default" {
  name       = "servian"
  subnet_ids = ["${aws_subnet.private.id}", "${aws_subnet.private-1.id}"]

  tags = {
    Name = "My PostgresDB subnet group"
  }
}

resource "aws_db_instance" "postgresdb" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "9.6.9"
  instance_class       = "db.t2.micro"
  identifier           = "demodb-postgres"
  multi_az             = false
  name                 = "app"
  username             = "postgres"
  password             = "${var.db_password}"
  db_subnet_group_name  = "${aws_db_subnet_group.default.name}"
  vpc_security_group_ids   = ["${aws_security_group.mydb1.id}"]
  # Snapshot name upon DB deletion
  final_snapshot_identifier = "demodb"

  # Database Deletion Protection
  deletion_protection = false
}
  

