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

###########################################
# Prefix list allowing VPC CIDR for example
###########################################

resource "aws_ec2_managed_prefix_list" "example" {
  name           = "All VPC CIDRs"
  address_family = "IPv4"
  max_entries    = 1

  entry {
    cidr        = data.aws_vpc.default.cidr_block
    description = "Default VPC CIDR"
  }
}

###########################
# Security groups examples
###########################

#######
# HTTP
#######
module "http_sg" {
  source = "../../modules/http-80"

  name        = "http-sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_ipv4 = ["0.0.0.0/0"]
}

###################################
# HTTP with ingress prefix list ids
###################################
module "http_with_ingress_prefix_list_ids_sg" {
  source = "../../modules/http-80"

  name        = "http-with-ingress-prefix-list-ids"
  description = "Security group with HTTP ports open within current VPC, egress ports are all world open"
  vpc_id      = data.aws_vpc.default.id

  # Allow ingress rules to be accessed only within specific prefix list IDs
  ingress_prefix_list_ids = [aws_ec2_managed_prefix_list.example.id]
}

#####################
# HTTP with MySQL #1
#####################
module "http_mysql_1_sg" {
  source = "../../modules/http-80"

  name            = "http-mysql-1"
  use_name_prefix = false

  description = "Security group with HTTP and MySQL ports open for everybody (IPv4 CIDR)"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_ipv4 = ["0.0.0.0/0"]

  # Add MySQL rules
  ingress_rules = ["mysql-tcp"]
}

#####################
# HTTP with MySQL #2
#####################
module "http_mysql_2_sg" {
  source = "../../modules/http-80"

  name        = "http-mysql-2"
  description = "Security group with HTTP and MySQL ports open within current VPC"
  vpc_id      = data.aws_vpc.default.id

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_ipv4 = [data.aws_vpc.default.cidr_block]
  ingress_cidr_ipv6 = [] # Not all VPCs have IPv6 enabled, but if you have it enabled, then this will work - ["${data.aws_vpc.default.ipv6_cidr_block}"]
}

###########################
# HTTP with egress minimal
###########################
module "http_with_egress_minimal_sg" {
  source = "../../modules/http-80"

  name        = "http-with-egress-minimal"
  description = "Security group with HTTP ports open within current VPC, and allow egress access to HTTP ports to the whole world"
  vpc_id      = data.aws_vpc.default.id

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_ipv4 = [data.aws_vpc.default.cidr_block]

  # Allow all rules for all protocols
  egress_rules = ["http-80-tcp"]
}

###########################
# HTTP with egress limited
###########################
module "http_with_egress_sg" {
  source = "../../modules/http-80"

  name        = "http-with-egress"
  description = "Security group with HTTP ports open within current VPC, and allow egress access just to small subnet"
  vpc_id      = data.aws_vpc.default.id

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_ipv4 = [data.aws_vpc.default.cidr_block]
  ingress_cidr_ipv6 = [] # Not all VPCs have IPv6 enabled, but if you have it enabled, then this will work - ["${data.aws_vpc.default.ipv6_cidr_block}"]

  # Allow egress rules to access anything (empty list means everything)
  egress_cidr_ipv4 = ["10.10.10.0/28"]
  egress_cidr_ipv6 = [] # Not all VPCs have IPv6 enabled, but if you have it enabled, then this will work - ["${data.aws_vpc.default.ipv6_cidr_block}"]
}
