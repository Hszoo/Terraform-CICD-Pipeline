terraform {
  backend "s3" {
    bucket         = "cicd-bucket-2000-0903-0909"
    key            = "cicd/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "cicdDynamodbTable"
    encrypt        = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

variable "env" {
  type    = string
  default = "cicd"
}

resource "random_id" "suffix" {
  byte_length = 4
}

# ------------------------------
# Module Definitions
# ------------------------------

module "iam" {
  source = "./iam"
  env    = var.env               
  suffix = random_id.suffix.hex   
}

module "ecr" {
  source = "./ecr"
  env    = var.env               
  suffix = random_id.suffix.hex   
}

module "s3" {
  source = "./s3"
  env    = var.env               
  suffix = random_id.suffix.hex   
}

module "codedeploy" {
  source              = "./codedeploy"
  env    = var.env               
  suffix = random_id.suffix.hex   
  codedeploy_role_arn = module.iam.codedeploy_role_arn
}