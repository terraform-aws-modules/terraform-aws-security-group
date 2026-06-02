provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  region   = "eu-west-1"
  name     = "ex-${basename(path.cwd)}"
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-security-group"
  }
}

################################################################################
# Security Group
################################################################################

module "security_group" {
  source = "../../"

  name        = local.name
  description = "Complete security group example"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    https-from-vpc = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = local.vpc_cidr
      description = "HTTPS from VPC"
    }

    http-from-ipv6 = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv6   = "2001:db8::/64"
      description = "HTTP from IPv6"
    }

    all-from-self = {
      ip_protocol                  = "-1"
      referenced_security_group_id = "self"
      description                  = "All protocols from self"
    }

    mysql-from-app = {
      from_port                    = 3306
      to_port                      = 3306
      ip_protocol                  = "tcp"
      referenced_security_group_id = aws_security_group.app.id
      description                  = "MySQL from app"
    }

    dns-from-prefix-list = {
      from_port      = 53
      to_port        = 53
      ip_protocol    = "udp"
      prefix_list_id = aws_ec2_managed_prefix_list.dns.id
      description    = "DNS from prefix list"
    }

    single-port-coalesce = {
      from_port   = 8080
      ip_protocol = "tcp"
      cidr_ipv4   = local.vpc_cidr
      description = "Single-port shorthand - to_port defaults to from_port"
    }

    ephemeral-from-vpc = {
      from_port   = 32768
      to_port     = 60999
      ip_protocol = "tcp"
      cidr_ipv4   = local.vpc_cidr
      description = "Ephemeral port range"
      tags = {
        Tier = "private"
      }
    }
  }

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "All outbound"
    }
  }

  vpc_associations = {
    secondary = {
      vpc_id = module.vpc_secondary.vpc_id
    }
  }

  timeouts = {
    create = "5m"
    delete = "10m"
  }

  tags = local.tags
}

################################################################################
# PostgreSQL preset submodule (single-protocol)
################################################################################

module "postgresql" {
  source = "../../modules/postgresql"

  name        = "${local.name}-postgresql"
  description = "PostgreSQL access from primary VPC and peer VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_ipv4 = {
    primary = local.vpc_cidr
    peer    = "192.168.0.0/16"
  }

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = local.tags
}

################################################################################
# Consul preset submodule (multi-protocol; sourced from peer SG)
################################################################################

module "consul" {
  source = "../../modules/consul"

  name        = "${local.name}-consul"
  description = "Consul access from peer SG and primary VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_ipv4 = {
    primary = local.vpc_cidr
  }

  ingress_referenced_security_group_id = {
    app = aws_security_group.app.id
  }

  tags = local.tags
}

################################################################################
# Disabled
################################################################################

module "disabled_security_group" {
  source = "../../"

  create = false

  name = "${local.name}-disabled"
}

module "disabled_submodule" {
  source = "../../modules/http-80"

  create = false

  name = "${local.name}-disabled-http"
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  tags = local.tags
}

module "vpc_secondary" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${local.name}-secondary"
  cidr = "10.1.0.0/16"

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet("10.1.0.0/16", 4, k)]

  tags = local.tags
}

resource "aws_security_group" "app" {
  name        = "${local.name}-app"
  description = "Stand-in application SG used as a referenced source"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

resource "aws_ec2_managed_prefix_list" "dns" {
  name           = "${local.name}-dns"
  address_family = "IPv4"
  max_entries    = 1

  entry {
    cidr        = local.vpc_cidr
    description = "VPC CIDR"
  }

  tags = local.tags
}
