resource "aws_ecr_repository" "cicd_ecr" {
  name = "${var.env}-ecr-${var.suffix}"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "cicd-ecr"
  }
}