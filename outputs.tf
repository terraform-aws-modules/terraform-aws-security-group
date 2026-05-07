################################################################################
# Security Group
################################################################################

output "arn" {
  description = "The ARN of the security group"
  value       = try(aws_security_group.this[0].arn, null)
}

output "id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, null)
}

output "vpc_id" {
  description = "The VPC ID"
  value       = try(aws_security_group.this[0].vpc_id, null)
}

output "owner_id" {
  description = "The owner ID"
  value       = try(aws_security_group.this[0].owner_id, null)
}

output "name" {
  description = "The name of the security group"
  value       = try(aws_security_group.this[0].name, null)
}
