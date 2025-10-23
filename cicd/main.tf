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
  suffix = random_id.suffix.hex
}

module "ecr" {
  source = "./ecr"
  suffix = random_id.suffix.hex
}

module "s3" {
  source = "./s3"
  suffix = random_id.suffix.hex
}

module "codedeploy" {
  source              = "./codedeploy"
  codedeploy_role_arn = module.iam.codedeploy_role_arn
}

output "codedeploy_app_name" {
  value = module.codedeploy.app_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}