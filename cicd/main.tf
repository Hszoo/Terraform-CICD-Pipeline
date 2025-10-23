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

# ------------------------------
# Module Definitions
# ------------------------------

module "iam" {
  source = "./iam"
}

module "ecr" {
  source = "./ecr"
}

module "s3" {
  source = "./s3"
}

module "codedeploy" {
  source = "./codedeploy"
  codedeploy_role_arn = module.iam.codedeploy_role_arn  # ✅ IAM 모듈 출력값 전달
}

output "codedeploy_app_name" {
  value = module.codedeploy.app_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}