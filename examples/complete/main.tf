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

################################################
# Security group with complete set of arguments
################################################
module "complete_sg" {
  source = "../../"

  name        = "complete-sg"
  description = "Security group with all available arguments set (this is just an example)"
  vpc_id      = "${data.aws_vpc.default.id}"

  tags = {
    Cash       = "king"
    Department = "kingdom"
  }

  # Default CIDR blocks, which will be used for all ingress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  ingress_cidr_blocks = ["10.10.0.0/16"]

  ingress_ipv6_cidr_blocks = ["2001:db8::/64"]

  # Prefix list ids to use in all ingress rules in this module.
  # ingress_prefix_list_ids = ["pl-123456"]
  # Open for all CIDRs defined in ingress_cidr_blocks
  ingress_rules = ["https-443-tcp"]

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0,2.2.2.2/32"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "30.30.30.30/32"
    },
    {
      from_port   = 10
      to_port     = 20
      protocol    = 6
      description = "Service name"
      cidr_blocks = "10.10.0.0/20"
    },
  ]

  # Open to IPV6 CIDR blocks (rule or from_port+to_port+protocol+description)
  ingress_with_ipv6_cidr_blocks = [
    {
      from_port        = 300
      to_port          = 400
      protocol         = "tcp"
      description      = "Service ports (ipv6)"
      ipv6_cidr_blocks = "2001:db8::/64"
    },
  ]

  # Open for security group id (rule or from_port+to_port+protocol+description)
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "${data.aws_security_group.default.id}"
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = 6
      description              = "Service name"
      source_security_group_id = "${data.aws_security_group.default.id}"
    },
  ]

  # Open for self (rule or from_port+to_port+protocol+description)
  ingress_with_self = [
    {
      rule = "all-all"
    },
    {
      from_port   = 30
      to_port     = 40
      protocol    = 6
      description = "Service name"
      self        = true
    },
    {
      from_port = 41
      to_port   = 51
      protocol  = 6
      self      = false
    },
  ]

  # Default CIDR blocks, which will be used for all egress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  egress_cidr_blocks = ["10.10.0.0/16"]

  egress_ipv6_cidr_blocks = ["2001:db8::/64"]

  # Prefix list ids to use in all egress rules in this module.
  # egress_prefix_list_ids = ["pl-123456"]
  # Open for all CIDRs defined in egress_cidr_blocks
  egress_rules = ["http-80-tcp"]

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  egress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0,2.2.2.2/32"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "30.30.30.30/32"
    },
    {
      from_port   = 10
      to_port     = 20
      protocol    = 6
      description = "Service name"
      cidr_blocks = "10.10.0.0/20"
    },
  ]

  # Open to IPV6 CIDR blocks (rule or from_port+to_port+protocol+description)
  egress_with_ipv6_cidr_blocks = [
    {
      from_port        = 300
      to_port          = 400
      protocol         = "tcp"
      description      = "Service ports (ipv6)"
      ipv6_cidr_blocks = "2001:db8::/64"
    },
  ]

  # Open for security group id (rule or from_port+to_port+protocol+description)
  egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "${data.aws_security_group.default.id}"
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = 6
      description              = "Service name"
      source_security_group_id = "${data.aws_security_group.default.id}"
    },
  ]

  # Open for self (rule or from_port+to_port+protocol+description)
  egress_with_self = [
    {
      rule = "all-all"
    },
    {
      from_port   = 30
      to_port     = 40
      protocol    = "tcp"
      description = "Service name"
      self        = true
    },
    {
      from_port = 41
      to_port   = 51
      protocol  = 6
      self      = false
    },
  ]
}

######################################################
# Security group with IPv4 and IPv6 sets of arguments
######################################################
module "ipv4_ipv6_example" {
  source = "../../"

  name        = "ipv4-ipv6-example"
  description = "IPv4 and IPv6 example"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports (ipv4)"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  ingress_with_ipv6_cidr_blocks = [
    {
      from_port        = 8080
      to_port          = 8090
      protocol         = "tcp"
      description      = "User-service ports (ipv6)"
      ipv6_cidr_blocks = "2001:db8::/64"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 8090
      to_port     = 8100
      protocol    = "tcp"
      description = "User-service ports (ipv4)"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_ipv6_cidr_blocks = [
    {
      from_port        = 8090
      to_port          = 8100
      protocol         = "tcp"
      description      = "User-service ports (ipv6)"
      ipv6_cidr_blocks = "2001:db8::/64"
    },
  ]
}
