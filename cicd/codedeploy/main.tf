variable "codedeploy_role_arn" {
  description = "IAM Role ARN for CodeDeploy"
  type        = string
}

resource "aws_codedeploy_app" "codedeploy_app" {
  name             = "minipro3-codedeploy-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "group" {
  app_name              = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name = "minipro3-codedeploy-group"
  service_role_arn      = var.codedeploy_role_arn

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  ec2_tag_filter {
    key   = "Name"
    value = "cicd-asg"
    type  = "KEY_AND_VALUE"
  }

  load_balancer_info {
    target_group_info {
      name = "my-cicd-alb-tg" 
    }
  }
}

output "app_name" {
  value = aws_codedeploy_app.codedeploy_app.name
}