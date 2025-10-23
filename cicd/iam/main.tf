# CodeDeploy 역할
resource "aws_iam_role" "codedeploy_role" {
  name = "hb05-CodeDeployServiceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "codedeploy.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# EC2 인스턴스 역할
resource "aws_iam_role" "ec2_role" {
  name = "hb05-EC2CodeDeployRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# S3 kms descrypt 권한
resource "aws_iam_policy" "kms_decrypt_policy" {
  name        = "AllowKMSDecrypt"
  description = "Allow EC2 instances to decrypt artifacts from KMS encrypted S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ]
        Resource = "arn:aws:kms:ap-northeast-2:329863774288:key/cfdbbf93-4ab3-4eee-8779-b71044391b71"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_kms_decrypt_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.kms_decrypt_policy.arn
}

# EC2 인스턴스 프로파일
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "hb05-EC2CodeDeployInstanceProfile"
  role = aws_iam_role.ec2_role.name
}