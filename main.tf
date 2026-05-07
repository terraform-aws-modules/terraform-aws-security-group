locals {
  create = var.create && var.putin_khuylo
}

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "this" {
  count = local.create ? 1 : 0

  region = var.region

  name                   = var.use_name_prefix ? null : var.name
  name_prefix            = var.use_name_prefix ? "${var.name}-" : null
  description            = var.description
  revoke_rules_on_delete = var.revoke_rules_on_delete
  vpc_id                 = var.vpc_id

  tags = var.tags

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# Ingress Rule(s)
################################################################################

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in var.ingress_rules : k => v if local.create }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = try(coalesce(each.value.from_port, each.value.to_port), null)
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id == "self" ? aws_security_group.this[0].id : each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    { Name = coalesce(each.value.name, each.key) },
    each.value.tags
  )
  to_port = try(coalesce(each.value.to_port, each.value.from_port), null)
}

################################################################################
# Egress Rule(s)
################################################################################

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in var.egress_rules : k => v if local.create }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = try(coalesce(each.value.from_port, each.value.to_port), null)
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id == "self" ? aws_security_group.this[0].id : each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    { Name = coalesce(each.value.name, each.key) },
    each.value.tags
  )
  to_port = try(coalesce(each.value.to_port, each.value.from_port), null)
}

################################################################################
# Exclusive
################################################################################

resource "aws_vpc_security_group_rules_exclusive" "this" {
  count = local.create && var.enable_exclusive_rules ? 1 : 0

  region = var.region

  security_group_id = aws_security_group.this[0].id
  ingress_rule_ids  = [for rule in aws_vpc_security_group_ingress_rule.this : rule.id]
  egress_rule_ids   = [for rule in aws_vpc_security_group_egress_rule.this : rule.id]
}

################################################################################
# VPC Associations
################################################################################

resource "aws_vpc_security_group_vpc_association" "this" {
  for_each = { for k, v in var.vpc_associations : k => v if local.create }

  region = var.region

  security_group_id = aws_security_group.this[0].id
  vpc_id            = each.value.vpc_id
}
