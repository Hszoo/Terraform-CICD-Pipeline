# IAM
output "ec2_instance_profile" {
  value = module.iam.ec2_instance_profile
}

# 환경 정보
output "env" {
  description = "Current environment name (e.g., dev, prod)"
  value       = var.env
}

output "suffix" {
  description = "Random unique suffix for resource names"
  value       = random_id.suffix.hex
}

# ECR
output "ecr_repository_name" {
  description = "ECR repository name"
  value       = module.ecr.repository_name
}

# S3
output "s3_bucket_name" {
  description = "S3 artifact bucket name"
  value       = module.s3.bucket_name
}

# CodeDeploy
output "codedeploy_app_name" {
  description = "CodeDeploy Application name"
  value       = module.codedeploy.app_name
}

output "codedeploy_group_name" {
  description = "CodeDeploy Deployment Group name"
  value       = module.codedeploy.group_name
}