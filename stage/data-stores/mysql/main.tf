terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "terraform-remote-bucket-hszoo"
    key            = "stage/mysql/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-remote-table-hszoo"
    encrypt        = true
  }
}

## RDS: Mysql 
resource "aws_db_instance" "rds_mysql" {
  identifier           = "hb05-mysql"
  allocated_storage    = 10
  db_name              = "svcdb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.mysqluser
  password             = var.mysqlpasswd
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  deletion_protection = false
}