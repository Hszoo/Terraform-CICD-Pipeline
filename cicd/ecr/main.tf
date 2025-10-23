resource "aws_ecr_repository" "cicd_ecr" {
  name = "hb05-ecr"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "hb05-ecr"
  }
}