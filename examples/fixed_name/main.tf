provider "aws" {
  region = "eu-west-1"
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = "${data.aws_vpc.default.id}"
}

##################################
# Security group with a fixed name
##################################
module "fixed_name_sg" {
  source = "../../"

  name            = "fixed-name-sg"
  description     = "Security group with a fixed name and minimal rules"
  use_name_prefix = "false"
  vpc_id          = "${data.aws_vpc.default.id}"

  tags = {
    Cash       = "king"
    Department = "kingdom"
  }

  # Default CIDR blocks, which will be used for all ingress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  ingress_cidr_blocks = ["10.10.0.0/16"]

  # Open for all CIDRs defined in ingress_cidr_blocks
  ingress_rules = ["https-443-tcp"]

  # Open for self (rule or from_port+to_port+protocol+description)
  ingress_with_self = [
    {
      rule = "all-all"
    },
  ]

  # Default CIDR blocks, which will be used for all egress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  egress_cidr_blocks = ["10.10.0.0/16"]

  # Open for self (rule or from_port+to_port+protocol+description)
  egress_with_self = [
    {
      rule = "all-all"
    },
  ]
}
