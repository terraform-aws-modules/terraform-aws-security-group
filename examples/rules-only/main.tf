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
  vpc_id = data.aws_vpc.default.id
}

########################################################
# Create SGs
########################################################

resource "aws_security_group" "service_one" {
  name        = "service_one"
  description = "Allow access from service two"
}

resource "aws_security_group" "service_two" {
  name        = "service_two"
  description = "Allow access from service one"
}

########################################################
# Add SG rules
########################################################

module "rules_one" {
  source = "../../"

  create_sg         = false
  security_group_id = aws_security_group.service_one.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service two"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_two.id
    },
  ]
}

module "rules_two" {
  source = "../../"

  create_sg         = false
  security_group_id = aws_security_group.service_two.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service one"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_one.id
    },
  ]
}

