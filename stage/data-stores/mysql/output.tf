output "db_address" {
  value = aws_db_instance.rds_mysql.address
}

output "db_port" {
  value = aws_db_instance.rds_mysql.port
}