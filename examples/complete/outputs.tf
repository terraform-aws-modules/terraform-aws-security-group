################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.security_group.arn
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.security_group.name
}

output "security_group_owner_id" {
  description = "The owner ID of the security group"
  value       = module.security_group.owner_id
}

output "security_group_vpc_id" {
  description = "The VPC ID of the security group"
  value       = module.security_group.vpc_id
}

################################################################################
# PostgreSQL preset submodule
################################################################################

output "postgresql_security_group_arn" {
  description = "The ARN of the postgresql security group"
  value       = module.postgresql.arn
}

output "postgresql_security_group_id" {
  description = "The ID of the postgresql security group"
  value       = module.postgresql.id
}

output "postgresql_security_group_name" {
  description = "The name of the postgresql security group"
  value       = module.postgresql.name
}

output "postgresql_security_group_owner_id" {
  description = "The owner ID of the postgresql security group"
  value       = module.postgresql.owner_id
}

output "postgresql_security_group_vpc_id" {
  description = "The VPC ID of the postgresql security group"
  value       = module.postgresql.vpc_id
}

################################################################################
# Consul preset submodule
################################################################################

output "consul_security_group_arn" {
  description = "The ARN of the consul security group"
  value       = module.consul.arn
}

output "consul_security_group_id" {
  description = "The ID of the consul security group"
  value       = module.consul.id
}

output "consul_security_group_name" {
  description = "The name of the consul security group"
  value       = module.consul.name
}

output "consul_security_group_owner_id" {
  description = "The owner ID of the consul security group"
  value       = module.consul.owner_id
}

output "consul_security_group_vpc_id" {
  description = "The VPC ID of the consul security group"
  value       = module.consul.vpc_id
}
