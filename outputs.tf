output "security_group_arn" {
  description = "The ARN of the security group"
  value       = try(aws_security_group.this[0].arn, aws_security_group.this_name_prefix[0].arn, "")
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, aws_security_group.this_name_prefix[0].id, "")
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = try(aws_security_group.this[0].vpc_id, aws_security_group.this_name_prefix[0].vpc_id, "")
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = try(aws_security_group.this[0].owner_id, aws_security_group.this_name_prefix[0].owner_id, "")
}

output "security_group_name" {
  description = "The name of the security group"
  value       = try(aws_security_group.this[0].name, aws_security_group.this_name_prefix[0].name, "")
}

output "security_group_description" {
  description = "The description of the security group"
  value       = try(aws_security_group.this[0].description, aws_security_group.this_name_prefix[0].description, "")
}
