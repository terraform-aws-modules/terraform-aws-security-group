provider "aws" {
  region = "eu-west-1"

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
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

##################################################
# VPC which is used as an argument in complete-sg
##################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "complete-sg-demo-vpc"
  cidr = "10.20.0.0/20"
}

#############################################################
# Security group which is used as an argument in complete-sg
#############################################################
module "main_sg" {
  source = "../../"

  name        = "main-sg"
  description = "Security group which is used as an argument in complete-sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
}

################################################
# Security group with complete set of arguments
################################################
module "complete_sg" {
  source = "../../"

  name        = "complete-sg"
  description = "Security group with all available arguments set (this is just an example)"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Cash       = "king"
    Department = "kingdom"
  }

  # Default CIDR blocks, which will be used for all ingress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  ingress_cidr_blocks = ["10.10.0.0/16"]

  ingress_ipv6_cidr_blocks = ["2001:db8::/64"]

  # Prefix list ids to use in all ingress rules in this module.
  # ingress_prefix_list_ids = [data.aws_prefix_list.s3.id, data.aws_prefix_list.dynamodb.id]

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

  # Open for security group id (rule or from_port+to_port+protocol+description)
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = data.aws_security_group.default.id
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = 6
      description              = "Service name"
      source_security_group_id = data.aws_security_group.default.id
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
      self      = true
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

  # Open for security group id (rule or from_port+to_port+protocol+description)
  egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = data.aws_security_group.default.id
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = 6
      description              = "Service name"
      source_security_group_id = data.aws_security_group.default.id
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
      self      = true
    },
  ]

  create_timeout = "15m"
  delete_timeout = "45m"
}

######################################################
# Security group with IPv4 and IPv6 sets of arguments
######################################################
module "ipv4_ipv6_example" {
  source = "../../"

  name        = "ipv4-ipv6-example"
  description = "IPv4 and IPv6 example"
  vpc_id      = data.aws_vpc.default.id

  ingress_with_cidr_blocks = [
    {
      from_port        = 8080
      to_port          = 8090
      protocol         = "tcp"
      description      = "User-service ports"
      cidr_blocks      = "0.0.0.0/0"
      ipv6_cidr_blocks = "2001:db8::/64"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port        = 8090
      to_port          = 8100
      protocol         = "tcp"
      description      = "User-service ports"
      cidr_blocks      = "0.0.0.0/0"
      ipv6_cidr_blocks = "2001:db8::/64"
    },
  ]
}

#################################
# Security group with fixed name
#################################
module "fixed_name_sg" {
  source = "../../"

  name        = "fixed-name-sg"
  description = "Security group with fixed name"
  vpc_id      = data.aws_vpc.default.id

  use_name_prefix = false

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
}

############################
# Only security group rules
############################
module "only_rules" {
  source = "../../"

  create_sg         = false
  security_group_id = module.complete_sg.security_group_id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service one"
      rule                     = "http-80-tcp"
      source_security_group_id = data.aws_security_group.default.id
    },
  ]
}

###################################
# Security group with prefix lists
###################################

data "aws_prefix_list" "s3" {
  filter {
    name   = "prefix-list-name"
    values = ["com.amazonaws.eu-west-1.s3"]
  }
}

data "aws_prefix_list" "dynamodb" {
  filter {
    name   = "prefix-list-name"
    values = ["com.amazonaws.eu-west-1.dynamodb"]
  }
}

module "prefix_list" {
  source = "../../"

  name        = "pl-sg"
  description = "Security group with prefix list"
  vpc_id      = data.aws_vpc.default.id

  ingress_prefix_list_ids = [data.aws_prefix_list.s3.id, data.aws_prefix_list.dynamodb.id]
  ingress_with_cidr_blocks = [
    {
      from_port       = 9100
      to_port         = 9100
      protocol        = 6 # "tcp"
      description     = "Arbitrary TCP port"
      prefix_list_ids = join(",", [data.aws_prefix_list.s3.id, data.aws_prefix_list.dynamodb.id])
    },
  ]
}

#################################
# Security group using prefix list
#################################
resource "aws_ec2_managed_prefix_list" "prefix_list_sg_example" {
  address_family = "IPv4"
  max_entries    = 1
  name           = "prefix-list-sg-example"

  entry {
    cidr        = module.vpc.vpc_cidr_block
    description = "VPC CIDR"
  }
}

module "prefix_list_sg" {
  source = "../../"

  name        = "prefix-list-sg"
  description = "Security group using prefix list and custom ingress rules"
  vpc_id      = data.aws_vpc.default.id

  use_name_prefix = false

  ingress_prefix_list_ids = [aws_ec2_managed_prefix_list.prefix_list_sg_example.id]
  ingress_with_prefix_list_ids = [
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
    },
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    },
  ]
}
