output "repository_url" {
  value = aws_ecr_repository.cicd_ecr.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.cicd_ecr.name
}