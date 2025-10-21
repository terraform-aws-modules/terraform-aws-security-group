module "sg" {
  source = "../../"

  create                 = var.create
  name                   = var.name
  use_name_prefix        = var.use_name_prefix
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags                   = var.tags

  ##########
  # Ingress
  ##########
  # Rules by names - open for default CIDR
  ingress_rules = sort(compact(distinct(concat(var.auto_ingress_rules, var.ingress_rules, [""]))))

  # Open for self
  ingress_with_self = concat(var.auto_ingress_with_self, var.ingress_with_self)

  # Open to IPv4 cidr blocks
  ingress_with_cidr_ipv4 = var.ingress_with_cidr_ipv4

  # Open to IPv6 cidr blocks
  ingress_with_cidr_ipv6 = var.ingress_with_cidr_ipv6

  # Open for security group id
  ingress_with_referenced_security_group_id = var.ingress_with_referenced_security_group_id

  # Open for prefix list id
  ingress_with_prefix_list_id = var.ingress_with_prefix_list_id

  # Default ingress CIDR blocks
  ingress_cidr_ipv4 = var.ingress_cidr_ipv4
  ingress_cidr_ipv6 = var.ingress_cidr_ipv6

  # Default prefix list ids
  ingress_prefix_list_ids = var.ingress_prefix_list_ids

  ###################
  # Computed Ingress
  ###################
  # Rules by names - open for default CIDR
  computed_ingress_rules = sort(compact(distinct(concat(var.auto_computed_ingress_rules, var.computed_ingress_rules, [""]))))

  # Open for self
  computed_ingress_with_self = concat(var.auto_computed_ingress_with_self, var.computed_ingress_with_self)

  # Open to IPv4 cidr blocks
  computed_ingress_with_cidr_ipv4 = var.computed_ingress_with_cidr_ipv4

  # Open to IPv6 cidr blocks
  computed_ingress_with_cidr_ipv6 = var.computed_ingress_with_cidr_ipv6

  # Open for security group id
  computed_ingress_with_referenced_security_group_id = var.computed_ingress_with_referenced_security_group_id

  # Open for prefix list id
  computed_ingress_with_prefix_list_id = var.computed_ingress_with_prefix_list_id

  #############################
  # Number of computed ingress
  #############################
  number_of_computed_ingress_rules                             = var.auto_number_of_computed_ingress_rules + var.number_of_computed_ingress_rules
  number_of_computed_ingress_with_self                         = var.auto_number_of_computed_ingress_with_self + var.number_of_computed_ingress_with_self
  number_of_computed_ingress_with_cidr_ipv4                    = var.number_of_computed_ingress_with_cidr_ipv4
  number_of_computed_ingress_with_cidr_ipv6                    = var.number_of_computed_ingress_with_cidr_ipv6
  number_of_computed_ingress_with_referenced_security_group_id = var.number_of_computed_ingress_with_referenced_security_group_id
  number_of_computed_ingress_with_prefix_list_id               = var.number_of_computed_ingress_with_prefix_list_id

  #########
  # Egress
  #########
  # Rules by names - open for default CIDR
  egress_rules = sort(compact(distinct(concat(var.auto_egress_rules, var.egress_rules, [""]))))

  # Open for self
  egress_with_self = concat(var.auto_egress_with_self, var.egress_with_self)

  # Open to IPv4 cidr blocks
  egress_with_cidr_ipv4 = var.egress_with_cidr_ipv4

  # Open to IPv6 cidr blocks
  egress_with_cidr_ipv6 = var.egress_with_cidr_ipv6

  # Open for security group id
  egress_with_referenced_security_group_id = var.egress_with_referenced_security_group_id

  # Open for prefix list id
  egress_with_prefix_list_id = var.egress_with_prefix_list_id

  # Default egress CIDR blocks
  egress_cidr_ipv4 = var.egress_cidr_ipv4
  egress_cidr_ipv6 = var.egress_cidr_ipv6

  # Default prefix list ids
  egress_prefix_list_ids = var.egress_prefix_list_ids

  ##################
  # Computed Egress
  ##################
  # Rules by names - open for default CIDR
  computed_egress_rules = sort(compact(distinct(concat(var.auto_computed_egress_rules, var.computed_egress_rules, [""]))))

  # Open for self
  computed_egress_with_self = concat(var.auto_computed_egress_with_self, var.computed_egress_with_self)

  # Open to IPv4 cidr blocks
  computed_egress_with_cidr_ipv4 = var.computed_egress_with_cidr_ipv4

  # Open to IPv6 cidr blocks
  computed_egress_with_cidr_ipv6 = var.computed_egress_with_cidr_ipv6

  # Open for security group id
  computed_egress_with_referenced_security_group_id = var.computed_egress_with_referenced_security_group_id

  # Open for prefix list id
  computed_egress_with_prefix_list_id = var.computed_egress_with_prefix_list_id

  #############################
  # Number of computed egress
  #############################
  number_of_computed_egress_rules                             = var.auto_number_of_computed_egress_rules + var.number_of_computed_egress_rules
  number_of_computed_egress_with_self                         = var.auto_number_of_computed_egress_with_self + var.number_of_computed_egress_with_self
  number_of_computed_egress_with_cidr_ipv4                    = var.number_of_computed_egress_with_cidr_ipv4
  number_of_computed_egress_with_cidr_ipv6                    = var.number_of_computed_egress_with_cidr_ipv6
  number_of_computed_egress_with_referenced_security_group_id = var.number_of_computed_egress_with_referenced_security_group_id
  number_of_computed_egress_with_prefix_list_id               = var.number_of_computed_egress_with_prefix_list_id
}
