#################
# Security group
#################
variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "create_sg" {
  description = "Whether to create security group"
  type        = bool
  default     = true
}

variable "security_group_id" {
  description = "ID of existing security group whose rules we will manage"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of security group - not required if create_sg is false"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "Time to wait for a security group to be created"
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Time to wait for a security group to be deleted"
  type        = string
  default     = "15m"
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_with_custom_blocks" {
  description = "List of ingress rules to create with specific cidr_blocks, prefix_list_ids, self, source_security_group_id or ipv6_cidr_blocks"

  type = list(object({
    description              = optional(string, "Ingress Rule")
    from_port                = optional(number)
    rule                     = optional(string, "_")
    to_port                  = optional(number)
    protocol                 = optional(string)
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    self                     = optional(bool)
    source_security_group_id = optional(string)
  }))

  default = []

  validation {
    condition = alltrue([
      for rule in var.ingress_with_custom_blocks : (
        rule.cidr_blocks != null ||
        rule.ipv6_cidr_blocks != null ||
        rule.prefix_list_ids != null ||
        rule.self != null ||
        rule.source_security_group_id != null
      )
    ])
    error_message = "Ingress rule must have at least one of cidr_blocks, ipv6_cidr_blocks, prefix_list_ids, self or source_security_group_id defined."
  }
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules"
  type        = list(string)
  default     = []
}

###################
# Computed Ingress
###################
variable "computed_ingress_rules" {
  description = "List of computed ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "computed_ingress_with_custom_blocks" {
  description = "List of computed ingress rules to create where cidr_blocks, prefix_list_ids, self, source_security_group_id or ipv6_cidr_blocks is defined"

  type = list(object({
    description              = optional(string, "Computed Ingress Rule")
    from_port                = optional(number)
    rule                     = optional(string, "_")
    to_port                  = optional(number)
    protocol                 = optional(string)
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    self                     = optional(bool)
    source_security_group_id = optional(string)
  }))

  default = []

  validation {
    condition = alltrue([
      for rule in var.computed_ingress_with_custom_blocks : (
        rule.cidr_blocks != null ||
        rule.ipv6_cidr_blocks != null ||
        rule.prefix_list_ids != null ||
        rule.self != null ||
        rule.source_security_group_id != null
      )
    ])
    error_message = "Computed ingress rule must have at least one of cidr_blocks, ipv6_cidr_blocks, prefix_list_ids, self or source_security_group_id defined."
  }
}

###################################
# Number of computed ingress rules
###################################
variable "number_of_computed_ingress_rules" {
  description = "Number of computed ingress rules to create by name"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_custom_blocks" {
  description = "Number of computed ingress rules to create where cidr_blocks, prefix_list_ids, self, source_security_group_id or ipv6_cidr_blocks is defined"
  type        = number
  default     = 0
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_custom_blocks" {
  description = "List of egress rules to create with specific cidr_blocks, prefix_list_ids, self, source_security_group_id or ipv6_cidr_blocks"

  type = list(object({
    description              = optional(string, "Egress Rule")
    from_port                = optional(number)
    rule                     = optional(string, "_")
    to_port                  = optional(number)
    protocol                 = optional(string)
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    self                     = optional(bool)
    source_security_group_id = optional(string)
  }))

  default = []

  validation {
    condition = alltrue([
      for rule in var.egress_with_custom_blocks : (
        rule.cidr_blocks != null ||
        rule.ipv6_cidr_blocks != null ||
        rule.prefix_list_ids != null ||
        rule.self != null ||
        rule.source_security_group_id != null
      )
    ])
    error_message = "Egress rule must have at least one of cidr_blocks, ipv6_cidr_blocks, prefix_list_ids, self or source_security_group_id defined."
  }
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["::/0"]
}

variable "egress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules"
  type        = list(string)
  default     = []
}

##################
# Computed Egress
##################
variable "computed_egress_rules" {
  description = "List of computed egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "computed_egress_with_custom_blocks" {
  description = "List of computed egress rules to create with specific cidr_blocks, prefix_list_ids, self, source_security_group_id or ipv6_cidr_blocks"

  type = list(object({
    description              = optional(string, "Computed Egress Rule")
    from_port                = optional(number)
    rule                     = optional(string, "_")
    to_port                  = optional(number)
    protocol                 = optional(string)
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    self                     = optional(bool)
    source_security_group_id = optional(string)
  }))

  default = []

  validation {
    condition = alltrue([
      for rule in var.computed_egress_with_custom_blocks : (
        rule.cidr_blocks != null ||
        rule.ipv6_cidr_blocks != null ||
        rule.prefix_list_ids != null ||
        rule.self != null ||
        rule.source_security_group_id != null
      )
    ])
    error_message = "Computed egress rule must have at least one of cidr_blocks, ipv6_cidr_blocks, prefix_list_ids, self or source_security_group_id defined."
  }
}

##################################
# Number of computed egress rules
##################################
variable "number_of_computed_egress_rules" {
  description = "Number of computed egress rules to create by name"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_custom_blocks" {
  description = "Number of computed egress rules to create where cidr_blocks, ipv6_cidr_blocks, prefix_list_ids, self or source_security_group_id is defined"
  type        = number
  default     = 0
}

variable "putin_khuylo" {
  description = "Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo!"
  type        = bool
  default     = true
}
