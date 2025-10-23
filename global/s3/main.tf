provider "aws" {
  # Configuration options
  region = "us-east-2"
}

## KMS KEY for S3 Bucket Encryption 
resource "aws_kms_key" "my_kms_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

## Create S3 Bucket 
resource "aws_s3_bucket" "s3_artifact_bucket" {
  bucket = "cicd-bucket-2000-0903-0909"

  force_destroy = true

  tags = {
    Name        = "cicd-bucket"
    Environment = "Dev"
  }
}

## Enable S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "s3_artifact_bucket_versioning" {
  bucket = aws_s3_bucket.s3_artifact_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

## S3 Bucket Encryption 
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_artifact_bucket_encryption" {
  bucket = aws_s3_bucket.s3_artifact_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.my_kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

## S3 Bucket Public Access Block 
resource "aws_s3_bucket_public_access_block" "s3_artifact_bucket_acceses_control" {
  bucket = aws_s3_bucket.s3_artifact_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## Dynamodb 
resource "aws_dynamodb_table" "dynamodb_artifact_table" {
  name         = "cicdDynamodbTable"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}