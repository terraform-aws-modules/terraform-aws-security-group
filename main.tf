#################
# Security group
#################
resource "aws_security_group" "this" {
  count = "${var.create}"

  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

###################################
# Ingress - List of rules (simple)
###################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "ingress_rules" {
  count = "${var.create ? length(var.ingress_rules) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "ingress"

  cidr_blocks      = ["${var.ingress_cidr_blocks}"]
  ipv6_cidr_blocks = ["${var.ingress_ipv6_cidr_blocks}"]
  prefix_list_ids  = ["${var.ingress_prefix_list_ids}"]
  description      = "${element(var.rules[var.ingress_rules[count.index]], 3)}"

  from_port = "${element(var.rules[var.ingress_rules[count.index]], 0)}"
  to_port   = "${element(var.rules[var.ingress_rules[count.index]], 1)}"
  protocol  = "${element(var.rules[var.ingress_rules[count.index]], 2)}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

##########################
# Ingress - Maps of rules
##########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  count = "${var.create ? length(var.ingress_with_source_security_group_id) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "ingress"

  source_security_group_id = "${lookup(var.ingress_with_source_security_group_id[count.index], "source_security_group_id")}"
  ipv6_cidr_blocks         = ["${var.ingress_ipv6_cidr_blocks}"]
  prefix_list_ids          = ["${var.ingress_prefix_list_ids}"]
  description              = "${lookup(var.ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")}"

  from_port = "${lookup(var.ingress_with_source_security_group_id[count.index], "from_port", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.ingress_with_source_security_group_id[count.index], "to_port", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.ingress_with_source_security_group_id[count.index], "protocol", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# Security group rules with "cidr_blocks", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = "${var.create ? length(var.ingress_with_cidr_blocks) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "ingress"

  cidr_blocks     = ["${split(",", lookup(var.ingress_with_cidr_blocks[count.index], "cidr_blocks", join(",", var.ingress_cidr_blocks)))}"]
  prefix_list_ids = ["${var.ingress_prefix_list_ids}"]
  description     = "${lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")}"

  from_port = "${lookup(var.ingress_with_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.ingress_with_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.ingress_with_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# Security group rules with "ipv6_cidr_blocks", but without "cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "ingress_with_ipv6_cidr_blocks" {
  count = "${var.create ? length(var.ingress_with_ipv6_cidr_blocks) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "ingress"

  ipv6_cidr_blocks = ["${split(",", lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "ipv6_cidr_blocks", join(",", var.ingress_ipv6_cidr_blocks)))}"]
  prefix_list_ids  = ["${var.ingress_prefix_list_ids}"]
  description      = "${lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "description", "Ingress Rule")}"

  from_port = "${lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.ingress_with_ipv6_cidr_blocks[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# Security group rules with "self", but without "cidr_blocks" and "source_security_group_id"
resource "aws_security_group_rule" "ingress_with_self" {
  count = "${var.create ? length(var.ingress_with_self) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "ingress"

  self             = "${lookup(var.ingress_with_self[count.index], "self", true)}"
  ipv6_cidr_blocks = ["${var.ingress_ipv6_cidr_blocks}"]
  prefix_list_ids  = ["${var.ingress_prefix_list_ids}"]
  description      = "${lookup(var.ingress_with_self[count.index], "description", "Ingress Rule")}"

  from_port = "${lookup(var.ingress_with_self[count.index], "from_port", element(var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.ingress_with_self[count.index], "to_port", element(var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.ingress_with_self[count.index], "protocol", element(var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

#################
# End of ingress
#################

##################################
# Egress - List of rules (simple)
##################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "egress_rules" {
  count = "${var.create ? length(var.egress_rules) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "egress"

  cidr_blocks      = ["${var.egress_cidr_blocks}"]
  ipv6_cidr_blocks = ["${var.egress_ipv6_cidr_blocks}"]
  prefix_list_ids  = ["${var.egress_prefix_list_ids}"]
  description      = "${element(var.rules[var.egress_rules[count.index]], 3)}"

  from_port = "${element(var.rules[var.egress_rules[count.index]], 0)}"
  to_port   = "${element(var.rules[var.egress_rules[count.index]], 1)}"
  protocol  = "${element(var.rules[var.egress_rules[count.index]], 2)}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

#########################
# Egress - Maps of rules
#########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "egress_with_source_security_group_id" {
  count = "${var.create ? length(var.egress_with_source_security_group_id) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "egress"

  source_security_group_id = "${lookup(var.egress_with_source_security_group_id[count.index], "source_security_group_id")}"
  ipv6_cidr_blocks         = ["${var.egress_ipv6_cidr_blocks}"]
  prefix_list_ids          = ["${var.egress_prefix_list_ids}"]
  description              = "${lookup(var.egress_with_source_security_group_id[count.index], "description", "Egress Rule")}"

  from_port = "${lookup(var.egress_with_source_security_group_id[count.index], "from_port", element(var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.egress_with_source_security_group_id[count.index], "to_port", element(var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.egress_with_source_security_group_id[count.index], "protocol", element(var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# Security group rules with "cidr_blocks", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  count = "${var.create ? length(var.egress_with_cidr_blocks) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "egress"

  cidr_blocks     = ["${split(",", lookup(var.egress_with_cidr_blocks[count.index], "cidr_blocks", join(",", var.egress_cidr_blocks)))}"]
  prefix_list_ids = ["${var.egress_prefix_list_ids}"]
  description     = "${lookup(var.egress_with_cidr_blocks[count.index], "description", "Egress Rule")}"

  from_port = "${lookup(var.egress_with_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.egress_with_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.egress_with_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# Security group rules with "ipv6_cidr_blocks", but without "cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "egress_with_ipv6_cidr_blocks" {
  count = "${var.create ? length(var.egress_with_ipv6_cidr_blocks) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "egress"

  ipv6_cidr_blocks = ["${split(",", lookup(var.egress_with_ipv6_cidr_blocks[count.index], "ipv6_cidr_blocks", join(",", var.egress_ipv6_cidr_blocks)))}"]
  prefix_list_ids  = ["${var.egress_prefix_list_ids}"]
  description      = "${lookup(var.egress_with_ipv6_cidr_blocks[count.index], "description", "Egress Rule")}"

  from_port = "${lookup(var.egress_with_ipv6_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.egress_with_ipv6_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.egress_with_ipv6_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.egress_with_ipv6_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.egress_with_ipv6_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.egress_with_ipv6_cidr_blocks[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# Security group rules with "self", but without "cidr_blocks" and "source_security_group_id"
resource "aws_security_group_rule" "egress_with_self" {
  count = "${var.create ? length(var.egress_with_self) : 0}"

  security_group_id = "${aws_security_group.this.id}"
  type              = "egress"

  self             = "${lookup(var.egress_with_self[count.index], "self", true)}"
  ipv6_cidr_blocks = ["${var.egress_ipv6_cidr_blocks}"]
  prefix_list_ids  = ["${var.egress_prefix_list_ids}"]
  description      = "${lookup(var.egress_with_self[count.index], "description", "Egress Rule")}"

  from_port = "${lookup(var.egress_with_self[count.index], "from_port", element(var.rules[lookup(var.egress_with_self[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.egress_with_self[count.index], "to_port", element(var.rules[lookup(var.egress_with_self[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.egress_with_self[count.index], "protocol", element(var.rules[lookup(var.egress_with_self[count.index], "rule", "_")], 2))}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

################
# End of egress
################

