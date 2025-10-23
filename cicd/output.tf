output "ec2_instance_profile" {
  value = module.iam.ec2_instance_profile
}

output "env" {
  description = "Current environment name (e.g., dev, prod)"
  value       = var.env
}

output "suffix" {
  description = "Random unique suffix for resource names"
  value       = random_id.suffix.hex
}