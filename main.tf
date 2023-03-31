##################################
# Get ID of created Security Group
##################################
locals {
  create = var.create && var.putin_khuylo

  this_sg_id = var.create_sg ? concat(aws_security_group.this.*.id, aws_security_group.this_name_prefix.*.id, [""])[0] : var.security_group_id
}

##########################
# Security group with name
##########################
resource "aws_security_group" "this" {
  count = local.create && var.create_sg && !var.use_name_prefix ? 1 : 0

  name                   = var.name
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}

#################################
# Security group with name_prefix
#################################
resource "aws_security_group" "this_name_prefix" {
  count = local.create && var.create_sg && var.use_name_prefix ? 1 : 0

  name_prefix            = "${var.name}-"
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
  count = local.create ? length(var.ingress_rules) : 0

  security_group_id = local.this_sg_id
  type              = "ingress"

  cidr_blocks      = var.ingress_cidr_blocks
  ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  prefix_list_ids  = var.ingress_prefix_list_ids
  description      = var.rules[var.ingress_rules[count.index]][3]

  from_port = var.rules[var.ingress_rules[count.index]][0]
  to_port   = var.rules[var.ingress_rules[count.index]][1]
  protocol  = var.rules[var.ingress_rules[count.index]][2]
}

# Computed - Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "computed_ingress_rules" {
  count = local.create ? var.number_of_computed_ingress_rules : 0

  security_group_id = local.this_sg_id
  type              = "ingress"

  cidr_blocks      = var.ingress_cidr_blocks
  ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  prefix_list_ids  = var.ingress_prefix_list_ids
  description      = var.rules[var.computed_ingress_rules[count.index]][3]

  from_port = var.rules[var.computed_ingress_rules[count.index]][0]
  to_port   = var.rules[var.computed_ingress_rules[count.index]][1]
  protocol  = var.rules[var.computed_ingress_rules[count.index]][2]
}

##########################
# Ingress - Maps of rules
##########################
resource "aws_security_group_rule" "ingress_with_custom_blocks" {
  count = local.create ? length(var.ingress_with_custom_blocks) : 0

  security_group_id = local.this_sg_id
  type              = "ingress"

  description = var.ingress_with_custom_blocks[count.index].description

  source_security_group_id = var.ingress_with_custom_blocks[count.index].source_security_group_id

  self = var.ingress_with_custom_blocks[count.index].self

  ipv6_cidr_blocks = var.ingress_with_custom_blocks[count.index].ipv6_cidr_blocks

  cidr_blocks = var.ingress_with_custom_blocks[count.index].cidr_blocks

  prefix_list_ids = var.ingress_with_custom_blocks[count.index].prefix_list_ids

  from_port = coalesce(
    var.ingress_with_custom_blocks[count.index].from_port,
    var.rules[var.ingress_with_custom_blocks[count.index].rule][0],
  )

  to_port = coalesce(
    var.ingress_with_custom_blocks[count.index].to_port,
    var.rules[var.ingress_with_custom_blocks[count.index].rule][1],
  )

  protocol = coalesce(
    var.ingress_with_custom_blocks[count.index].protocol,
    var.rules[var.ingress_with_custom_blocks[count.index].rule][2],
  )
}

# Computed - Security group rules
resource "aws_security_group_rule" "computed_ingress_with_custom_blocks" {
  count = local.create ? var.number_of_computed_ingress_with_custom_blocks : 0

  security_group_id = local.this_sg_id
  type              = "ingress"

  source_security_group_id = var.computed_ingress_with_custom_blocks[count.index].source_security_group_id

  self = var.computed_ingress_with_custom_blocks[count.index].self

  ipv6_cidr_blocks = var.computed_ingress_with_custom_blocks[count.index].ipv6_cidr_blocks

  cidr_blocks = var.computed_ingress_with_custom_blocks[count.index].cidr_blocks

  prefix_list_ids = var.computed_ingress_with_custom_blocks[count.index].prefix_list_ids

  description = coalesce(
    var.computed_ingress_with_custom_blocks[count.index].description,
    "Ingress Rule",
  )

  from_port = coalesce(
    var.computed_ingress_with_custom_blocks[count.index].from_port,
    var.rules[var.computed_ingress_with_custom_blocks[count.index].rule][0],
  )

  to_port = coalesce(
    var.computed_ingress_with_custom_blocks[count.index].to_port,
    var.rules[var.computed_ingress_with_custom_blocks[count.index].rule][1],
  )

  protocol = coalesce(
    var.computed_ingress_with_custom_blocks[count.index].protocol,
    var.rules[var.computed_ingress_with_custom_blocks[count.index].rule][2],
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
  count = local.create ? length(var.egress_rules) : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  prefix_list_ids  = var.egress_prefix_list_ids
  description      = var.rules[var.egress_rules[count.index]][3]

  from_port = var.rules[var.egress_rules[count.index]][0]
  to_port   = var.rules[var.egress_rules[count.index]][1]
  protocol  = var.rules[var.egress_rules[count.index]][2]
}

# Computed - Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "computed_egress_rules" {
  count = local.create ? var.number_of_computed_egress_rules : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  prefix_list_ids  = var.egress_prefix_list_ids
  description      = var.rules[var.computed_egress_rules[count.index]][3]

  from_port = var.rules[var.computed_egress_rules[count.index]][0]
  to_port   = var.rules[var.computed_egress_rules[count.index]][1]
  protocol  = var.rules[var.computed_egress_rules[count.index]][2]
}

#########################
# Egress - Maps of rules
#########################
resource "aws_security_group_rule" "egress_with_custom_blocks" {
  count = local.create ? length(var.egress_with_custom_blocks) : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  description = var.egress_with_custom_blocks[count.index].description

  source_security_group_id = var.egress_with_custom_blocks[count.index].source_security_group_id

  self = var.egress_with_custom_blocks[count.index].self

  ipv6_cidr_blocks = var.egress_with_custom_blocks[count.index].ipv6_cidr_blocks

  cidr_blocks = var.egress_with_custom_blocks[count.index].cidr_blocks

  prefix_list_ids = var.egress_with_custom_blocks[count.index].prefix_list_ids

  from_port = coalesce(
    var.egress_with_custom_blocks[count.index].from_port,
    var.rules[var.egress_with_custom_blocks[count.index].rule][0],
  )

  to_port = coalesce(
    var.egress_with_custom_blocks[count.index].to_port,
    var.rules[var.egress_with_custom_blocks[count.index].rule][1],
  )

  protocol = coalesce(
    var.egress_with_custom_blocks[count.index].protocol,
    var.rules[var.egress_with_custom_blocks[count.index].rule][2],
  )
}

# Computed - Security group rules
resource "aws_security_group_rule" "computed_egress_with_custom_blocks" {
  count = local.create ? var.number_of_computed_egress_with_custom_blocks : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  source_security_group_id = var.computed_egress_with_custom_blocks[count.index].source_security_group_id

  self = var.computed_egress_with_custom_blocks[count.index].self

  ipv6_cidr_blocks = var.computed_egress_with_custom_blocks[count.index].ipv6_cidr_blocks

  cidr_blocks = var.computed_egress_with_custom_blocks[count.index].cidr_blocks

  prefix_list_ids = var.computed_egress_with_custom_blocks[count.index].prefix_list_ids

  description = coalesce(
    var.computed_egress_with_custom_blocks[count.index].description,
    "Ingress Rule",
  )

  from_port = coalesce(
    var.computed_egress_with_custom_blocks[count.index].from_port,
    var.rules[var.computed_egress_with_custom_blocks[count.index].rule][0],
  )

  to_port = coalesce(
    var.computed_egress_with_custom_blocks[count.index].to_port,
    var.rules[var.computed_egress_with_custom_blocks[count.index].rule][1],
  )

  protocol = coalesce(
    var.computed_egress_with_custom_blocks[count.index].protocol,
    var.rules[var.computed_egress_with_custom_blocks[count.index].rule][2],
  )
}

################
# End of egress
################
