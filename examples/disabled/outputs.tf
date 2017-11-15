output "this_security_group_id" {
  description = "The ID of the security group"
  value       = "${module.complete_sg_disabled.this_security_group_id}"
}
