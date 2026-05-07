module "wrapper" {
  source = "../"

  for_each = var.items

  create                 = try(each.value.create, var.defaults.create, true)
  description            = try(each.value.description, var.defaults.description, null)
  egress_rules           = try(each.value.egress_rules, var.defaults.egress_rules, {})
  enable_exclusive_rules = try(each.value.enable_exclusive_rules, var.defaults.enable_exclusive_rules, true)
  ingress_rules          = try(each.value.ingress_rules, var.defaults.ingress_rules, {})
  name                   = try(each.value.name, var.defaults.name, "")
  putin_khuylo           = try(each.value.putin_khuylo, var.defaults.putin_khuylo, true)
  region                 = try(each.value.region, var.defaults.region, null)
  revoke_rules_on_delete = try(each.value.revoke_rules_on_delete, var.defaults.revoke_rules_on_delete, false)
  tags                   = try(each.value.tags, var.defaults.tags, {})
  timeouts               = try(each.value.timeouts, var.defaults.timeouts, null)
  use_name_prefix        = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
  vpc_associations       = try(each.value.vpc_associations, var.defaults.vpc_associations, {})
  vpc_id                 = try(each.value.vpc_id, var.defaults.vpc_id, null)
}
