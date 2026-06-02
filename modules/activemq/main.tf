# Generated from generate/catalog.tf — do not edit manually.

locals {
  ingress_with_cidr_ipv4 = {
    for pair in setproduct(keys(var.preset_ingress_rules), keys(var.ingress_cidr_ipv4)) :
    "${pair[0]}/${pair[1]}" => merge(
      var.preset_ingress_rules[pair[0]],
      { cidr_ipv4 = var.ingress_cidr_ipv4[pair[1]] }
    )
  }

  ingress_with_cidr_ipv6 = {
    for pair in setproduct(keys(var.preset_ingress_rules), keys(var.ingress_cidr_ipv6)) :
    "${pair[0]}/${pair[1]}" => merge(
      var.preset_ingress_rules[pair[0]],
      { cidr_ipv6 = var.ingress_cidr_ipv6[pair[1]] }
    )
  }

  ingress_with_prefix_list_id = {
    for pair in setproduct(keys(var.preset_ingress_rules), keys(var.ingress_prefix_list_id)) :
    "${pair[0]}/${pair[1]}" => merge(
      var.preset_ingress_rules[pair[0]],
      { prefix_list_id = var.ingress_prefix_list_id[pair[1]] }
    )
  }

  ingress_with_referenced_security_group_id = {
    for pair in setproduct(keys(var.preset_ingress_rules), keys(var.ingress_referenced_security_group_id)) :
    "${pair[0]}/${pair[1]}" => merge(
      var.preset_ingress_rules[pair[0]],
      { referenced_security_group_id = var.ingress_referenced_security_group_id[pair[1]] }
    )
  }

  preset_ingress_combined = merge(
    local.ingress_with_cidr_ipv4,
    local.ingress_with_cidr_ipv6,
    local.ingress_with_prefix_list_id,
    local.ingress_with_referenced_security_group_id,
  )
}

module "security_group" {
  source = "../../"

  create                 = var.create
  region                 = var.region
  name                   = var.name
  use_name_prefix        = var.use_name_prefix
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags                   = var.tags
  timeouts               = var.timeouts
  vpc_associations       = var.vpc_associations
  enable_exclusive_rules = var.enable_exclusive_rules

  ingress_rules = merge(
    local.preset_ingress_combined,
    var.ingress_rules,
  )

  egress_rules = var.egress_rules
}
