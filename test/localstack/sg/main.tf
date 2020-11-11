module "vpc" {
  source = "git@github.com:HBOCodeLabs/terraform-aws-vpc.git?ref=2020.9.25.1-5"

  region = "${var.region}"
  environment = "${var.environment}"
  cluster = "${var.cluster}"
  service = "${var.service}"
  project = "${var.project}"

  vpc_cidr_block = "${var.vpc_cidr_block}"
  iam_permissions_boundary = "${var.iam_permissions_boundary}"

  vpc_flow_logs_enabled = false
  vpn_endpoint_enable = false

  owner = "${var.owner}"
  owner-slack-channel = "${var.owner_slack_channel}"
}

module "security_group" {
  source = "../../../"

  vpc_id = "${module.vpc.vpc_id}"
  name = "securitygroup-test"
  use_name_prefix = "false"
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = []
}
