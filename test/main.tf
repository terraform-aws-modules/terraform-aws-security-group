module "security_group" {
  source = "./.."

  vpc_id = "vpc-00d6b51d02b2d5160"
  name = "securitygroup-test"
  use_name_prefix = "false"
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}
