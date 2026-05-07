# Generated from generate/templates/outputs.tf.tftpl — do not edit manually.

output "arn" {
  description = "The ARN of the security group"
  value       = module.security_group.arn
}

output "id" {
  description = "The ID of the security group"
  value       = module.security_group.id
}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.security_group.vpc_id
}

output "owner_id" {
  description = "The owner ID"
  value       = module.security_group.owner_id
}

output "name" {
  description = "The name of the security group"
  value       = module.security_group.name
}
