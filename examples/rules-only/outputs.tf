output "service_one_security_group_arn" {
  description = "The ARN of the security group for service one"
  value       = aws_security_group.service_one.arn
}

output "service_one_security_group_id" {
  description = "The ID of the security group for service one"
  value       = aws_security_group.service_one.id
}

output "service_tow_security_group_arn" {
  description = "The ARN of the security group for service two"
  value       = aws_security_group.service_two.arn
}

output "service_two_security_group_id" {
  description = "The ID of the security group for service two"
  value       = aws_security_group.service_two.id
}
