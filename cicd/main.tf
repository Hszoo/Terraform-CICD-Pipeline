terraform {
  backend "s3" {
    bucket         = "terraform-remote-bucket-hszoo"
    key            = "cicd/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-remote-table-hszoo"
    encrypt        = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
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
  source              = "./codedeploy"
  codedeploy_role_arn = module.iam.codedeploy_role_arn
}