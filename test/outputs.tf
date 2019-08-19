output "this_security_group_id" {
  value = "${module.security_group.this_security_group_id}"
}

output "this_security_group_vpc_id" {
  value = "${module.security_group.this_security_group_vpc_id}"
}

output "this_security_group_owner_id" {
  value = "${module.security_group.this_security_group_owner_id}"
}

output "this_security_group_name" {
  value = "${module.security_group.this_security_group_name}"
}

output "this_security_group_description" {
  value = "${module.security_group.this_security_group_description}"
}
