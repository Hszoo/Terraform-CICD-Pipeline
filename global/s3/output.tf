output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_artifact_bucket.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb_artifact_table.name
}