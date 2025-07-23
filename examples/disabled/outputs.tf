output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.complete_sg_disabled.security_group_arn
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.complete_sg_disabled.security_group_id
}
