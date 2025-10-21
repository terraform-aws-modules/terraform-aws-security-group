##################################
# Get ID of created Security Group
##################################
locals {
  create = var.create && var.putin_khuylo

  this_sg_id = var.create_sg ? concat(aws_security_group.this.*.id, aws_security_group.this_name_prefix.*.id, [""])[0] : var.security_group_id

  ingress_rules_ipv4            = setproduct(var.ingress_rules, var.ingress_cidr_ipv4)
  ingress_rules_ipv6            = setproduct(var.ingress_rules, var.ingress_cidr_ipv6)
  ingress_rules_prefix_list_ids = setproduct(var.ingress_rules, var.ingress_prefix_list_ids)

  egress_rules_ipv4            = setproduct(var.egress_rules, var.egress_cidr_ipv4)
  egress_rules_ipv6            = setproduct(var.egress_rules, var.egress_cidr_ipv6)
  egress_rules_prefix_list_ids = setproduct(var.egress_rules, var.egress_prefix_list_ids)
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
# Security group rules with "cidr_ipv4" and it uses list of rules names
resource "aws_vpc_security_group_ingress_rule" "ingress_rules_ipv4" {
  count = local.create ? length(local.ingress_rules_ipv4) : 0

  security_group_id = local.this_sg_id

  cidr_ipv4   = local.ingress_rules_ipv4[count.index][1]
  description = var.rules[local.ingress_rules_ipv4[count.index][0]][3]

  from_port   = var.rules[local.ingress_rules_ipv4[count.index][0]][0]
  to_port     = var.rules[local.ingress_rules_ipv4[count.index][0]][1]
  ip_protocol = var.rules[local.ingress_rules_ipv4[count.index][0]][2]

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules_ipv6" {
  count = local.create ? length(local.ingress_rules_ipv6) : 0

  security_group_id = local.this_sg_id

  cidr_ipv6   = local.ingress_rules_ipv6[count.index][1]
  description = var.rules[local.ingress_rules_ipv6[count.index][0]][3]

  from_port   = var.rules[local.ingress_rules_ipv6[count.index][0]][0]
  to_port     = var.rules[local.ingress_rules_ipv6[count.index][0]][1]
  ip_protocol = var.rules[local.ingress_rules_ipv6[count.index][0]][2]

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules_prefix_list_ids" {
  count = local.create ? length(local.ingress_rules_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = local.ingress_rules_prefix_list_ids[count.index][1]
  description    = var.rules[local.ingress_rules_prefix_list_ids[count.index][0]][3]

  from_port   = var.rules[local.ingress_rules_prefix_list_ids[count.index][0]][0]
  to_port     = var.rules[local.ingress_rules_prefix_list_ids[count.index][0]][1]
  ip_protocol = var.rules[local.ingress_rules_prefix_list_ids[count.index][0]][2]

  tags = var.tags
}

# Computed - Security group rules with "cidr_ipv4" and it uses list of rules names
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_rules_ipv4" {
  count = local.create ? var.number_of_computed_ingress_rules * length(var.ingress_cidr_ipv4) : 0

  security_group_id = local.this_sg_id

  # Reference for looping in tf 0.11.0: https://serverfault.com/questions/833810/terraform-use-nested-loops-with-count
  cidr_ipv4   = var.ingress_cidr_ipv4[floor(count.index / var.number_of_computed_ingress_rules)]
  description = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][3]

  from_port   = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][0]
  to_port     = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][1]
  ip_protocol = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][2]

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "computed_ingress_rules_ipv6" {
  count = local.create ? var.number_of_computed_ingress_rules * length(var.ingress_cidr_ipv6) : 0

  security_group_id = local.this_sg_id

  # Reference for looping in tf 0.11.0: https://serverfault.com/questions/833810/terraform-use-nested-loops-with-count
  cidr_ipv6   = var.ingress_cidr_ipv6[floor(count.index / var.number_of_computed_ingress_rules)]
  description = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][3]

  from_port   = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][0]
  to_port     = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][1]
  ip_protocol = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][2]

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "computed_ingress_rules_prefix_list_ids" {
  count = local.create ? var.number_of_computed_ingress_rules * length(var.ingress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  # Reference for looping in tf 0.11.0: https://serverfault.com/questions/833810/terraform-use-nested-loops-with-count
  prefix_list_id = var.ingress_prefix_list_ids[floor(count.index / var.number_of_computed_ingress_rules)]
  description    = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][3]

  from_port   = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][0]
  to_port     = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][1]
  ip_protocol = var.rules[var.computed_ingress_rules[count.index % var.number_of_computed_ingress_rules]][2]

  tags = var.tags
}

##########################
# Ingress - Maps of rules
##########################
# Security group rules with "source_security_group_id", but without "cidr_ipv4" and "self"
resource "aws_vpc_security_group_ingress_rule" "ingress_with_referenced_security_group_id" {
  count = local.create ? length(var.ingress_with_referenced_security_group_id) : 0

  security_group_id = local.this_sg_id

  referenced_security_group_id = var.ingress_with_referenced_security_group_id[count.index]["referenced_security_group_id"]
  description = lookup(
    var.ingress_with_referenced_security_group_id[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_referenced_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.ingress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.ingress_with_referenced_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.ingress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.ingress_with_referenced_security_group_id[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.ingress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "source_security_group_id", but without "cidr_ipv4" and "self"
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_referenced_security_group_id" {
  count = local.create ? var.number_of_computed_ingress_with_referenced_security_group_id : 0

  security_group_id = local.this_sg_id

  referenced_security_group_id = var.computed_ingress_with_referenced_security_group_id[count.index]["referenced_security_group_id"]
  description = lookup(
    var.computed_ingress_with_referenced_security_group_id[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_referenced_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_ingress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_ingress_with_referenced_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_ingress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_ingress_with_referenced_security_group_id[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.computed_ingress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules allow ingress from allowed all ingress_prefix_list_ids
resource "aws_vpc_security_group_ingress_rule" "ingress_with_referenced_security_group_id_prefix_list" {
  count = local.create ? length(var.ingress_with_referenced_security_group_id) * length(var.ingress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.ingress_prefix_list_ids[floor(count.index / length(var.ingress_with_referenced_security_group_id))]
  description = lookup(
    var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
    "from_port",
    var.rules[lookup(
      var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
    "to_port",
    var.rules[lookup(
      var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
    "ip_protocol",
    var.rules[lookup(
      var.ingress_with_referenced_security_group_id[count.index % length(var.ingress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "cidr_ipv4"
resource "aws_vpc_security_group_ingress_rule" "ingress_with_cidr_ipv4" {
  count = local.create ? length(var.ingress_with_cidr_ipv4) : 0

  security_group_id = local.this_sg_id

  cidr_ipv4 = var.ingress_with_cidr_ipv4[count.index]["cidr_ipv4"]

  description = lookup(
    var.ingress_with_cidr_ipv4[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_cidr_ipv4[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_cidr_ipv4[count.index], "rule", "_")][0],
  )

  to_port = lookup(
    var.ingress_with_cidr_ipv4[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_cidr_ipv4[count.index], "rule", "_")][1],
  )

  ip_protocol = lookup(
    var.ingress_with_cidr_ipv4[count.index],
    "ip_protocol",
    var.rules[lookup(var.ingress_with_cidr_ipv4[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "cidr_ipv4", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_cidr_ipv4" {
  count = local.create ? var.number_of_computed_ingress_with_cidr_ipv4 : 0

  security_group_id = local.this_sg_id

  cidr_ipv4 = var.computed_ingress_with_cidr_ipv4[count.index]["cidr_ipv4"]

  description = lookup(
    var.computed_ingress_with_cidr_ipv4[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_cidr_ipv4[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_ingress_with_cidr_ipv4[count.index],
      "rule",
      "_",
    )][0],
  )

  to_port = lookup(
    var.computed_ingress_with_cidr_ipv4[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_ingress_with_cidr_ipv4[count.index],
      "rule",
      "_",
    )][1],
  )

  ip_protocol = lookup(
    var.computed_ingress_with_cidr_ipv4[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.computed_ingress_with_cidr_ipv4[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "ipv6_cidr_blocks", but without "cidr_ipv4", "source_security_group_id" and "self"
resource "aws_vpc_security_group_ingress_rule" "ingress_with_cidr_ipv6" {
  count = local.create ? length(var.ingress_with_cidr_ipv6) : 0

  security_group_id = local.this_sg_id

  cidr_ipv6 = var.ingress_with_cidr_ipv6[count.index]["cidr_ipv6"]

  description = lookup(
    var.ingress_with_cidr_ipv6[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_cidr_ipv6[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_cidr_ipv6[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.ingress_with_cidr_ipv6[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_cidr_ipv6[count.index], "rule", "_")][1],
  )
  ip_protocol = lookup(
    var.ingress_with_cidr_ipv6[count.index],
    "ip_protocol",
    var.rules[lookup(var.ingress_with_cidr_ipv6[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "ipv6_cidr_blocks", but without "cidr_ipv4", "source_security_group_id" and "self"
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_cidr_ipv6" {
  count = local.create ? var.number_of_computed_ingress_with_cidr_ipv6 : 0

  security_group_id = local.this_sg_id

  cidr_ipv6 = var.computed_ingress_with_cidr_ipv6[count.index]["cidr_ipv6"]

  description = lookup(
    var.computed_ingress_with_cidr_ipv6[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_cidr_ipv6[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_ingress_with_cidr_ipv6[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_ingress_with_cidr_ipv6[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_ingress_with_cidr_ipv6[count.index],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_ingress_with_cidr_ipv6[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.computed_ingress_with_cidr_ipv6[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "self", but without "cidr_ipv4" and "source_security_group_id"
resource "aws_vpc_security_group_ingress_rule" "ingress_with_self" {
  count = local.create ? length(var.ingress_with_self) : 0

  security_group_id            = local.this_sg_id
  referenced_security_group_id = local.this_sg_id

  description = lookup(
    var.ingress_with_self[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_self[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.ingress_with_self[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")][1],
  )
  ip_protocol = lookup(
    var.ingress_with_self[count.index],
    "ip_protocol",
    var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Security group rules allow ingress from allowed all ingress_prefix_list_ids for ingress_with_self
resource "aws_vpc_security_group_ingress_rule" "ingress_with_self_prefix_list_ids" {
  count = local.create ? length(var.ingress_with_self) * length(var.ingress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.ingress_prefix_list_ids[floor(count.index / length(var.ingress_with_self))]
  description = lookup(
    var.ingress_with_self[count.index % length(var.ingress_with_self)],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_self[count.index % length(var.ingress_with_self)],
    "from_port",
    var.rules[lookup(
      var.ingress_with_self[count.index % length(var.ingress_with_self)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.ingress_with_self[count.index % length(var.ingress_with_self)],
    "to_port",
    var.rules[lookup(
      var.ingress_with_self[count.index % length(var.ingress_with_self)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.ingress_with_self[count.index % length(var.ingress_with_self)],
    "ip_protocol",
    var.rules[lookup(
      var.ingress_with_self[count.index % length(var.ingress_with_self)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "self", but without "cidr_ipv4" and "source_security_group_id"
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_self" {
  count = local.create ? var.number_of_computed_ingress_with_self : 0

  security_group_id            = local.this_sg_id
  referenced_security_group_id = local.this_sg_id

  description = lookup(
    var.computed_ingress_with_self[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_self[count.index],
    "from_port",
    var.rules[lookup(var.computed_ingress_with_self[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.computed_ingress_with_self[count.index],
    "to_port",
    var.rules[lookup(var.computed_ingress_with_self[count.index], "rule", "_")][1],
  )
  ip_protocol = lookup(
    var.computed_ingress_with_self[count.index],
    "ip_protocol",
    var.rules[lookup(var.computed_ingress_with_self[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Security group rules allow ingress from allowed all ingress_prefix_list_ids for computed_ingress_with_self
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_self_prefix_list_ids" {
  count = local.create ? var.number_of_computed_ingress_with_self * length(var.ingress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.ingress_prefix_list_ids[floor(count.index / var.number_of_computed_ingress_with_self)]
  description = lookup(
    var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
    "from_port",
    var.rules[lookup(
      var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
    "to_port",
    var.rules[lookup(
      var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
    "ip_protocol",
    var.rules[lookup(
      var.computed_ingress_with_self[count.index % var.number_of_computed_ingress_with_self],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_ingress_rule" "ingress_with_prefix_list_id" {
  count = var.create ? length(var.ingress_with_prefix_list_id) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.ingress_with_prefix_list_id[count.index]["prefix_list_id"]

  description = lookup(
    var.ingress_with_prefix_list_id[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_prefix_list_id[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_prefix_list_id[count.index], "rule", "_")][0],
  )

  to_port = lookup(
    var.ingress_with_prefix_list_id[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_prefix_list_id[count.index], "rule", "_")][1],
  )

  ip_protocol = lookup(
    var.ingress_with_prefix_list_id[count.index],
    "ip_protocol",
    var.rules[lookup(var.ingress_with_prefix_list_id[count.index], "rule", "_")][2],
  )

  tags = var.tags
}


# Security group rules with "ingress_prefix_list_ids" for "ingress_with_prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_ingress_rule" "ingress_with_prefix_list_id_default_prefix_list_id" {
  count = local.create ? length(var.ingress_with_prefix_list_id) * length(var.ingress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.ingress_prefix_list_ids[floor(count.index / length(var.ingress_with_prefix_list_id))]
  description = lookup(
    var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
    "from_port",
    var.rules[lookup(
      var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
    "to_port",
    var.rules[lookup(
      var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
    "ip_protocol",
    var.rules[lookup(
      var.ingress_with_prefix_list_id[count.index % length(var.ingress_with_prefix_list_id)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_prefix_list_id" {
  count = var.create ? var.number_of_computed_ingress_with_prefix_list_id : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.computed_ingress_with_prefix_list_id[count.index]["prefix_list_id"]

  description = lookup(
    var.computed_ingress_with_prefix_list_id[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_prefix_list_id[count.index],
    "from_port",
    var.rules[lookup(var.computed_ingress_with_prefix_list_id[count.index], "rule", "_")][0],
  )

  to_port = lookup(
    var.computed_ingress_with_prefix_list_id[count.index],
    "to_port",
    var.rules[lookup(var.computed_ingress_with_prefix_list_id[count.index], "rule", "_")][1],
  )

  ip_protocol = lookup(
    var.computed_ingress_with_prefix_list_id[count.index],
    "ip_protocol",
    var.rules[lookup(var.computed_ingress_with_prefix_list_id[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Security group rules with "ingress_prefix_list_ids" for "computed_ingress_with_prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_ingress_rule" "computed_ingress_with_prefix_list_ids_prefix_list_ids" {
  count = local.create ? var.number_of_computed_ingress_with_prefix_list_id * length(var.ingress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.ingress_prefix_list_ids[floor(count.index / var.number_of_computed_ingress_with_prefix_list_id)]
  description = lookup(
    var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
    "from_port",
    var.rules[lookup(
      var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
    "to_port",
    var.rules[lookup(
      var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
    "ip_protocol",
    var.rules[lookup(
      var.computed_ingress_with_prefix_list_id[count.index % var.number_of_computed_ingress_with_prefix_list_id],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

#################
# End of ingress
#################

##################################
# Egress - List of rules (simple)
##################################
# Security group rules with "cidr_ipv4" and it uses list of rules names
resource "aws_vpc_security_group_egress_rule" "egress_rules_ipv4" {
  count = local.create ? length(local.egress_rules_ipv4) : 0

  security_group_id = local.this_sg_id

  cidr_ipv4   = local.egress_rules_ipv4[count.index][1]
  description = var.rules[local.egress_rules_ipv4[count.index][0]][3]

  from_port   = var.rules[local.egress_rules_ipv4[count.index][0]][0]
  to_port     = var.rules[local.egress_rules_ipv4[count.index][0]][1]
  ip_protocol = var.rules[local.egress_rules_ipv4[count.index][0]][2]

  tags = var.tags
}

# Security group rules with "cidr_ipv6" and it uses list of rules names
resource "aws_vpc_security_group_egress_rule" "egress_rules_ipv6" {
  count = local.create ? length(local.egress_rules_ipv6) : 0

  security_group_id = local.this_sg_id

  cidr_ipv6   = local.egress_rules_ipv6[count.index][1]
  description = var.rules[local.egress_rules_ipv6[count.index][0]][3]

  from_port   = var.rules[local.egress_rules_ipv6[count.index][0]][0]
  to_port     = var.rules[local.egress_rules_ipv6[count.index][0]][1]
  ip_protocol = var.rules[local.egress_rules_ipv6[count.index][0]][2]

  tags = var.tags
}

# Security group rules with "prefix_list_id" and it uses list of rules names
resource "aws_vpc_security_group_egress_rule" "egress_rules_prefix_list_ids" {
  count = local.create ? length(local.egress_rules_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = local.egress_rules_prefix_list_ids[count.index][1]
  description    = var.rules[local.egress_rules_prefix_list_ids[count.index][0]][3]

  from_port   = var.rules[local.egress_rules_prefix_list_ids[count.index][0]][0]
  to_port     = var.rules[local.egress_rules_prefix_list_ids[count.index][0]][1]
  ip_protocol = var.rules[local.egress_rules_prefix_list_ids[count.index][0]][2]

  tags = var.tags
}

# Computed - Security group rules with "cidr_ipv4" and it uses list of rules names
resource "aws_vpc_security_group_egress_rule" "computed_egress_rules_ipv4" {
  count = local.create ? var.number_of_computed_egress_rules * length(var.egress_cidr_ipv4) : 0

  security_group_id = local.this_sg_id

  cidr_ipv4   = var.egress_cidr_ipv4[floor(count.index / var.number_of_computed_egress_rules)]
  description = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][3]

  from_port   = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][0]
  to_port     = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][1]
  ip_protocol = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][2]

  tags = var.tags
}

# Computed - Security group rules with "cidr_ipv6" and it uses list of rules names
resource "aws_vpc_security_group_egress_rule" "computed_egress_rules_ipv6" {
  count = local.create ? var.number_of_computed_egress_rules * length(var.egress_cidr_ipv6) : 0

  security_group_id = local.this_sg_id

  cidr_ipv6   = var.egress_cidr_ipv6[floor(count.index / var.number_of_computed_egress_rules)]
  description = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][3]

  from_port   = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][0]
  to_port     = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][1]
  ip_protocol = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][2]

  tags = var.tags
}

# Computed - Security group rules with "prefix_list_id" and it uses list of rules names
resource "aws_vpc_security_group_egress_rule" "computed_egress_rules_prefix_list_ids" {
  count = local.create ? var.number_of_computed_egress_rules * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / var.number_of_computed_egress_rules)]
  description    = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][3]

  from_port   = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][0]
  to_port     = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][1]
  ip_protocol = var.rules[var.computed_egress_rules[count.index % var.number_of_computed_egress_rules]][2]

  tags = var.tags
}

#########################
# Egress - Maps of rules
#########################
# Security group rules with "referenced_security_group_id", but without "cidr_ipv4" and "self"
resource "aws_vpc_security_group_egress_rule" "egress_with_referenced_security_group_id" {
  count = local.create ? length(var.egress_with_referenced_security_group_id) : 0

  security_group_id = local.this_sg_id

  referenced_security_group_id = var.egress_with_referenced_security_group_id[count.index]["referenced_security_group_id"]
  description = lookup(
    var.egress_with_referenced_security_group_id[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_referenced_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.egress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.egress_with_referenced_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.egress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.egress_with_referenced_security_group_id[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.egress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules allow egress from allowed all egress_prefix_list_ids
resource "aws_vpc_security_group_egress_rule" "egress_with_referenced_security_group_id_prefix_list" {
  count = local.create ? length(var.egress_with_referenced_security_group_id) * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / length(var.egress_with_referenced_security_group_id))]
  description = lookup(
    var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
    "from_port",
    var.rules[lookup(
      var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
    "to_port",
    var.rules[lookup(
      var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
    "ip_protocol",
    var.rules[lookup(
      var.egress_with_referenced_security_group_id[count.index % length(var.egress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "referenced_security_group_id", but without "cidr_ipv4" and "self"
resource "aws_vpc_security_group_egress_rule" "computed_egress_with_referenced_security_group_id" {
  count = local.create ? var.number_of_computed_egress_with_referenced_security_group_id : 0

  security_group_id = local.this_sg_id

  referenced_security_group_id = var.computed_egress_with_referenced_security_group_id[count.index]["referenced_security_group_id"]
  description = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.computed_egress_with_referenced_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules allow egress from allowed all egress_prefix_list_ids
resource "aws_vpc_security_group_egress_rule" "computed_egress_with_referenced_security_group_id_prefix_list" {
  count = local.create ? var.number_of_computed_egress_with_referenced_security_group_id * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / var.number_of_computed_egress_with_referenced_security_group_id)]
  description = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
    "ip_protocol",
    var.rules[lookup(
      var.computed_egress_with_referenced_security_group_id[count.index % length(var.computed_egress_with_referenced_security_group_id)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "cidr_ipv4"
resource "aws_vpc_security_group_egress_rule" "egress_with_cidr_ipv4" {
  count = local.create ? length(var.egress_with_cidr_ipv4) : 0

  security_group_id = local.this_sg_id

  cidr_ipv4 = var.egress_with_cidr_ipv4[count.index]["cidr_ipv4"]

  description = lookup(
    var.egress_with_cidr_ipv4[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_cidr_ipv4[count.index],
    "from_port",
    var.rules[lookup(var.egress_with_cidr_ipv4[count.index], "rule", "_")][0],
  )

  to_port = lookup(
    var.egress_with_cidr_ipv4[count.index],
    "to_port",
    var.rules[lookup(var.egress_with_cidr_ipv4[count.index], "rule", "_")][1],
  )

  ip_protocol = lookup(
    var.egress_with_cidr_ipv4[count.index],
    "ip_protocol",
    var.rules[lookup(var.egress_with_cidr_ipv4[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

resource "aws_vpc_security_group_egress_rule" "computed_egress_with_cidr_ipv4" {
  count = local.create ? var.number_of_computed_egress_with_cidr_ipv4 : 0

  security_group_id = local.this_sg_id

  cidr_ipv4 = var.computed_egress_with_cidr_ipv4[count.index]["cidr_ipv4"]

  description = lookup(
    var.computed_egress_with_cidr_ipv4[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_cidr_ipv4[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_cidr_ipv4[count.index],
      "rule",
      "_",
    )][0],
  )

  to_port = lookup(
    var.computed_egress_with_cidr_ipv4[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_cidr_ipv4[count.index],
      "rule",
      "_",
    )][1],
  )

  ip_protocol = lookup(
    var.computed_egress_with_cidr_ipv4[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.computed_egress_with_cidr_ipv4[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "ipv6_cidr_blocks", but without "cidr_ipv4", "source_security_group_id" and "self"
resource "aws_vpc_security_group_egress_rule" "egress_with_cidr_ipv6" {
  count = local.create ? length(var.egress_with_cidr_ipv6) : 0

  security_group_id = local.this_sg_id

  cidr_ipv6 = var.egress_with_cidr_ipv6[count.index]["cidr_ipv6"]

  description = lookup(
    var.egress_with_cidr_ipv6[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_cidr_ipv6[count.index],
    "from_port",
    var.rules[lookup(var.egress_with_cidr_ipv6[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.egress_with_cidr_ipv6[count.index],
    "to_port",
    var.rules[lookup(var.egress_with_cidr_ipv6[count.index], "rule", "_")][1],
  )
  ip_protocol = lookup(
    var.egress_with_cidr_ipv6[count.index],
    "ip_protocol",
    var.rules[lookup(var.egress_with_cidr_ipv6[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "cidr_ipv6", but without "cidr_ipv4", "source_security_group_id" and "self"

resource "aws_vpc_security_group_egress_rule" "computed_egress_with_cidr_ipv6" {
  count = local.create ? var.number_of_computed_egress_with_cidr_ipv6 : 0

  security_group_id = local.this_sg_id

  cidr_ipv6 = var.computed_egress_with_cidr_ipv6[count.index]["cidr_ipv6"]

  description = lookup(
    var.computed_egress_with_cidr_ipv6[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_cidr_ipv6[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_cidr_ipv6[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_egress_with_cidr_ipv6[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_cidr_ipv6[count.index],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_egress_with_cidr_ipv6[count.index],
    "ip_protocol",
    var.rules[lookup(
      var.computed_egress_with_cidr_ipv6[count.index],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "self", but without "cidr_ipv4" and "source_security_group_id"
resource "aws_vpc_security_group_egress_rule" "egress_with_self" {
  count = local.create ? length(var.egress_with_self) : 0

  security_group_id            = local.this_sg_id
  referenced_security_group_id = local.this_sg_id

  description = lookup(
    var.egress_with_self[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_self[count.index],
    "from_port",
    var.rules[lookup(var.egress_with_self[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.egress_with_self[count.index],
    "to_port",
    var.rules[lookup(var.egress_with_self[count.index], "rule", "_")][1],
  )
  ip_protocol = lookup(
    var.egress_with_self[count.index],
    "ip_protocol",
    var.rules[lookup(var.egress_with_self[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Security group rules allow egress from allowed all egress_prefix_list_ids for egress_with_self
resource "aws_vpc_security_group_egress_rule" "egress_with_self_prefix_list_ids" {
  count = local.create ? length(var.egress_with_self) * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / length(var.egress_with_self))]
  description = lookup(
    var.egress_with_self[count.index % length(var.egress_with_self)],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_self[count.index % length(var.egress_with_self)],
    "from_port",
    var.rules[lookup(
      var.egress_with_self[count.index % length(var.egress_with_self)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.egress_with_self[count.index % length(var.egress_with_self)],
    "to_port",
    var.rules[lookup(
      var.egress_with_self[count.index % length(var.egress_with_self)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.egress_with_self[count.index % length(var.egress_with_self)],
    "ip_protocol",
    var.rules[lookup(
      var.egress_with_self[count.index % length(var.egress_with_self)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "self", but without "cidr_ipv4" and "source_security_group_id"
resource "aws_vpc_security_group_egress_rule" "computed_egress_with_self" {
  count = local.create ? var.number_of_computed_egress_with_self : 0

  security_group_id            = local.this_sg_id
  referenced_security_group_id = local.this_sg_id

  description = lookup(
    var.computed_egress_with_self[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_self[count.index],
    "from_port",
    var.rules[lookup(var.computed_egress_with_self[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.computed_egress_with_self[count.index],
    "to_port",
    var.rules[lookup(var.computed_egress_with_self[count.index], "rule", "_")][1],
  )
  ip_protocol = lookup(
    var.computed_egress_with_self[count.index],
    "ip_protocol",
    var.rules[lookup(var.computed_egress_with_self[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Security group rules allow egress from allowed all egress_prefix_list_ids for computed_egress_with_self
resource "aws_vpc_security_group_egress_rule" "computed_egress_with_self_prefix_list_ids" {
  count = local.create ? var.number_of_computed_egress_with_self * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / var.number_of_computed_egress_with_self)]
  description = lookup(
    var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
    "ip_protocol",
    var.rules[lookup(
      var.computed_egress_with_self[count.index % var.number_of_computed_egress_with_self],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Security group rules with "prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_egress_rule" "egress_with_prefix_list_id" {
  count = var.create ? length(var.egress_with_prefix_list_id) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_with_prefix_list_id[count.index]["prefix_list_id"]

  description = lookup(
    var.egress_with_prefix_list_id[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_prefix_list_id[count.index],
    "from_port",
    var.rules[lookup(var.egress_with_prefix_list_id[count.index], "rule", "_")][0],
  )

  to_port = lookup(
    var.egress_with_prefix_list_id[count.index],
    "to_port",
    var.rules[lookup(var.egress_with_prefix_list_id[count.index], "rule", "_")][1],
  )

  ip_protocol = lookup(
    var.egress_with_prefix_list_id[count.index],
    "ip_protocol",
    var.rules[lookup(var.egress_with_prefix_list_id[count.index], "rule", "_")][2],
  )

  tags = var.tags
}


# Security group rules with "egress_prefix_list_ids" for "egress_with_prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_egress_rule" "egress_with_prefix_list_id_default_prefix_list_id" {
  count = local.create ? length(var.egress_with_prefix_list_id) * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / length(var.egress_with_prefix_list_id))]
  description = lookup(
    var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
    "description",
    "egress Rule",
  )

  from_port = lookup(
    var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
    "from_port",
    var.rules[lookup(
      var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
    "to_port",
    var.rules[lookup(
      var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
    "ip_protocol",
    var.rules[lookup(
      var.egress_with_prefix_list_id[count.index % length(var.egress_with_prefix_list_id)],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

# Computed - Security group rules with "prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_egress_rule" "computed_egress_with_prefix_list_id" {
  count = var.create ? var.number_of_computed_egress_with_prefix_list_id : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.computed_egress_with_prefix_list_id[count.index]["prefix_list_id"]

  description = lookup(
    var.computed_egress_with_prefix_list_id[count.index],
    "description",
    "egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_prefix_list_id[count.index],
    "from_port",
    var.rules[lookup(var.computed_egress_with_prefix_list_id[count.index], "rule", "_")][0],
  )

  to_port = lookup(
    var.computed_egress_with_prefix_list_id[count.index],
    "to_port",
    var.rules[lookup(var.computed_egress_with_prefix_list_id[count.index], "rule", "_")][1],
  )

  ip_protocol = lookup(
    var.computed_egress_with_prefix_list_id[count.index],
    "ip_protocol",
    var.rules[lookup(var.computed_egress_with_prefix_list_id[count.index], "rule", "_")][2],
  )

  tags = var.tags
}

# Security group rules with "egress_prefix_list_ids" for "computed_egress_with_prefix_list_id", but without "cidr_ipv4", "self" or "source_security_group_id"
resource "aws_vpc_security_group_egress_rule" "computed_egress_with_prefix_list_ids_prefix_list_ids" {
  count = local.create ? var.number_of_computed_egress_with_prefix_list_id * length(var.egress_prefix_list_ids) : 0

  security_group_id = local.this_sg_id

  prefix_list_id = var.egress_prefix_list_ids[floor(count.index / var.number_of_computed_egress_with_prefix_list_id)]
  description = lookup(
    var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
      "rule",
      "_",
    )][1],
  )
  ip_protocol = lookup(
    var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
    "ip_protocol",
    var.rules[lookup(
      var.computed_egress_with_prefix_list_id[count.index % var.number_of_computed_egress_with_prefix_list_id],
      "rule",
      "_",
    )][2],
  )

  tags = var.tags
}

################
# End of egress
################
