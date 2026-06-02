# Generated from generate/templates/variables.tf.tftpl — do not edit manually.

variable "create" {
  description = "Controls if resources should be created (affects nearly all resources)"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Security Group
################################################################################

variable "name" {
  description = "Name of security group"
  type        = string
  default     = ""
}

variable "use_name_prefix" {
  description = "Whether to use the name (`name`) as a prefix, appending a random suffix"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID of the VPC where the security group is created"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Create and delete timeout configurations for the security group"
  type = object({
    create = optional(string)
    delete = optional(string)
  })
  default = null
}

################################################################################
# Ingress Rule(s)
################################################################################

variable "preset_ingress_rules" {
  description = "Preset ingress rule definitions for this service. Defaults to the curated catalog set; pass `{}` to disable, or override individual entries"
  type = map(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = optional(string)
  }))
  default = {
    redshift = {
      from_port   = 5439
      to_port     = 5439
      ip_protocol = "tcp"
      description = "Redshift"
    }
  }
  nullable = false
}

variable "ingress_cidr_ipv4" {
  description = "Map of IPv4 CIDRs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the CIDRs. Each entry produces one ingress rule per preset rule"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "ingress_cidr_ipv6" {
  description = "Map of IPv6 CIDRs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the CIDRs. Each entry produces one ingress rule per preset rule"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "ingress_prefix_list_id" {
  description = "Map of prefix list IDs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the prefix list IDs. Each entry produces one ingress rule per preset rule"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "ingress_referenced_security_group_id" {
  description = "Map of source security group IDs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the security group IDs. Use `self` as a value to reference the security group created by this module. Each entry produces one ingress rule per preset rule"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "ingress_rules" {
  description = "Additional security group ingress rules to merge with the preset rules"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.ingress_rules :
      length(compact([v.cidr_ipv4, v.cidr_ipv6, v.prefix_list_id, v.referenced_security_group_id])) == 1
    ])
    error_message = "Each ingress rule must set exactly one of cidr_ipv4, cidr_ipv6, prefix_list_id, or referenced_security_group_id."
  }
}

variable "egress_rules" {
  description = "Security group egress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.egress_rules :
      length(compact([v.cidr_ipv4, v.cidr_ipv6, v.prefix_list_id, v.referenced_security_group_id])) == 1
    ])
    error_message = "Each egress rule must set exactly one of cidr_ipv4, cidr_ipv6, prefix_list_id, or referenced_security_group_id."
  }
}

################################################################################
# VPC Associations
################################################################################

variable "vpc_associations" {
  description = "Map of VPC IDs to associate the security group to"
  type = map(object({
    vpc_id = string
  }))
  default = {}
}

variable "enable_exclusive_rules" {
  description = "Whether to enforce that only the rules declared by this module exist on the security group. When true, out-of-band rules added via the AWS console or other Terraform configurations will be reverted on next apply"
  type        = bool
  default     = true
}
