output "db_endpoint" {
  value = "${aws_db_instance.postgresdb.endpoint}"
}

output "alb_dns_name" {
   value = "${aws_alb.main.dns_name}"
 }