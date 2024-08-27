##################################
# Get ID of created Security Group
##################################
locals {
  create = var.create && var.putin_khuylo

  this_sg_id = var.create_sg ? aws_security_group.this[0].id : var.security_group_id
}

##########################
# Security group
##########################
resource "aws_security_group" "this" {
  count = local.create && var.create_sg ? 1 : 0

  name                   = var.use_name_prefix ? null : var.name
  name_prefix            = var.use_name_prefix ? "${var.name}-" : null
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}

###################################
# Ingress - List of rules (simple)
###################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "ingress_rules" {
  for_each = local.create ? toset(var.ingress_rules) : toset([])

  security_group_id = local.this_sg_id
  type              = "ingress"

  cidr_blocks      = var.ingress_cidr_blocks
  ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  prefix_list_ids  = var.ingress_prefix_list_ids
  description      = var.rules[each.value][3]

  from_port = var.rules[each.value][0]
  to_port   = var.rules[each.value][1]
  protocol  = var.rules[each.value][2]
}

##########################
# Ingress - Maps of rules
##########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  for_each = {
    for ingress in var.ingress_with_source_security_group_id :
    "${lookup(ingress, "from_port", var.rules[lookup(ingress, "rule", "_")][0])}-${lookup(ingress, "to_port", var.rules[lookup(ingress, "rule", "_")][1])}-${lookup(ingress, "protocol", var.rules[lookup(ingress, "rule", "_")][2])}" => ingress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "ingress"

  source_security_group_id = lookup(
    each.value,
    "source_security_group_id"
  )

  prefix_list_ids = var.ingress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][2],
  )
}

# Security group rules with "cidr_blocks", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  for_each = {
    for ingress in var.ingress_with_cidr_blocks :
    "${lookup(ingress, "from_port", var.rules[lookup(ingress, "rule", "_")][0])}-${lookup(ingress, "to_port", var.rules[lookup(ingress, "rule", "_")][1])}-${lookup(ingress, "protocol", var.rules[lookup(ingress, "rule", "_")][2])}" => ingress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "ingress"

  cidr_blocks = compact(split(
    ",",
    lookup(
      each.value,
      "cidr_blocks",
      join(",", var.ingress_cidr_blocks),
    ),
  ))
  ipv6_cidr_blocks = compact(split(
    ",",
    lookup(
      each.value,
      "ipv6_cidr_blocks",
      join(",", var.ingress_ipv6_cidr_blocks),
    ),
  ))
  prefix_list_ids = var.ingress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(each.value, "rule", "_")][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(each.value, "rule", "_")][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(each.value, "rule", "_")][2],
  )
}

# Security group rules with "self", but without "cidr_blocks" and "source_security_group_id"
resource "aws_security_group_rule" "ingress_with_self" {
  for_each = {
    for ingress in var.ingress_with_self :
    "${lookup(ingress, "from_port", var.rules[lookup(ingress, "rule", "_")][0])}-${lookup(ingress, "to_port", var.rules[lookup(ingress, "rule", "_")][1])}-${lookup(ingress, "protocol", var.rules[lookup(ingress, "rule", "_")][2])}" => ingress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "ingress"

  self            = lookup(each.value, "self", true)
  prefix_list_ids = var.ingress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(each.value, "rule", "_")][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(each.value, "rule", "_")][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(each.value, "rule", "_")][2],
  )
}

# Security group rules with "prefix_list_ids", but without "cidr_blocks", "self" or "source_security_group_id"
resource "aws_security_group_rule" "ingress_with_prefix_list_ids" {
  for_each = {
    for ingress in var.ingress_with_prefix_list_ids :
    "${lookup(ingress, "from_port", var.rules[lookup(ingress, "rule", "_")][0])}-${lookup(ingress, "to_port", var.rules[lookup(ingress, "rule", "_")][1])}-${lookup(ingress, "protocol", var.rules[lookup(ingress, "rule", "_")][2])}" => ingress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "ingress"

  prefix_list_ids = var.ingress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(each.value, "rule", "_")][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(each.value, "rule", "_")][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(each.value, "rule", "_")][2],
  )
}

#################
# End of ingress
#################

##################################
# Egress - List of rules (simple)
##################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "egress_rules" {
  for_each = local.create ? toset(var.ingress_rules) : toset([])

  security_group_id = local.this_sg_id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  prefix_list_ids  = var.egress_prefix_list_ids
  description      = var.rules[each.value][3]

  from_port = var.rules[each.value][0]
  to_port   = var.rules[each.value][1]
  protocol  = var.rules[each.value][2]
}

#########################
# Egress - Maps of rules
#########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "egress_with_source_security_group_id" {
  for_each = {
    for egress in var.egress_with_source_security_group_id :
    "${lookup(egress, "from_port", var.rules[lookup(egress, "rule", "_")][0])}-${lookup(egress, "to_port", var.rules[lookup(egress, "rule", "_")][1])}-${lookup(egress, "protocol", var.rules[lookup(egress, "rule", "_")][2])}" => egress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "egress"

  source_security_group_id = lookup(
    each.value,
    "source_security_group_id"
  )
  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][2],
  )
}

# Security group rules with "cidr_blocks", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  for_each = {
    for egress in var.egress_with_cidr_blocks :
    "${lookup(egress, "from_port", var.rules[lookup(egress, "rule", "_")][0])}-${lookup(egress, "to_port", var.rules[lookup(egress, "rule", "_")][1])}-${lookup(egress, "protocol", var.rules[lookup(egress, "rule", "_")][2])}" => egress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "egress"

  cidr_blocks = compact(split(
    ",",
    lookup(
      each.value,
      "cidr_blocks",
      join(",", var.egress_cidr_blocks),
    ),
  ))
  ipv6_cidr_blocks = compact(split(
    ",",
    lookup(
      each.value,
      "ipv6_cidr_blocks",
      join(",", var.egress_ipv6_cidr_blocks),
    ),
  ))
  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(each.value, "rule", "_")][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(each.value, "rule", "_")][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(each.value, "rule", "_")][2],
  )
}

# Security group rules with "self", but without "cidr_blocks" and "source_security_group_id"
resource "aws_security_group_rule" "egress_with_self" {
  for_each = {
    for egress in var.egress_with_self :
    "${lookup(egress, "from_port", var.rules[lookup(egress, "rule", "_")][0])}-${lookup(egress, "to_port", var.rules[lookup(egress, "rule", "_")][1])}-${lookup(egress, "protocol", var.rules[lookup(egress, "rule", "_")][2])}" => egress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "egress"

  self            = lookup(each.value, "self", true)
  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(each.value, "rule", "_")][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(each.value, "rule", "_")][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(each.value, "rule", "_")][2],
  )
}

# Security group rules with "egress_prefix_list_ids", but without "cidr_blocks", "self" or "source_security_group_id"
resource "aws_security_group_rule" "egress_with_prefix_list_ids" {
  for_each = {
    for egress in var.egress_with_prefix_list_ids :
    "${lookup(egress, "from_port", var.rules[lookup(egress, "rule", "_")][0])}-${lookup(egress, "to_port", var.rules[lookup(egress, "rule", "_")][1])}-${lookup(egress, "protocol", var.rules[lookup(egress, "rule", "_")][2])}" => egress
    if local.create
  }

  security_group_id = local.this_sg_id
  type              = "egress"

  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    each.value,
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    each.value,
    "from_port",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    each.value,
    "to_port",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    each.value,
    "protocol",
    var.rules[lookup(
      each.value,
      "rule",
      "_",
    )][2],
  )
}

################
# End of egress
################
