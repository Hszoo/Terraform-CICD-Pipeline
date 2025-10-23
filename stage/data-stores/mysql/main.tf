terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "cicd-bucket-2000-0903-0909"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "cicdDynamodbTable"
    encrypt        = true
  }
}

## RDS: Mysql 
resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.mysqluser
  password             = var.mysqlpasswd
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}