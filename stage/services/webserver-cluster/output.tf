output "alb_dns_url" {
  value = "http://${aws_lb.ec2_lb.dns_name}"
}