module "wrapper" {
  source = "../../modules/rabbitmq"

  for_each = var.items

  create                               = try(each.value.create, var.defaults.create, true)
  description                          = try(each.value.description, var.defaults.description, "Security Group managed by Terraform")
  egress_rules                         = try(each.value.egress_rules, var.defaults.egress_rules, {})
  enable_exclusive_rules               = try(each.value.enable_exclusive_rules, var.defaults.enable_exclusive_rules, true)
  ingress_cidr_ipv4                    = try(each.value.ingress_cidr_ipv4, var.defaults.ingress_cidr_ipv4, {})
  ingress_cidr_ipv6                    = try(each.value.ingress_cidr_ipv6, var.defaults.ingress_cidr_ipv6, {})
  ingress_prefix_list_id               = try(each.value.ingress_prefix_list_id, var.defaults.ingress_prefix_list_id, {})
  ingress_referenced_security_group_id = try(each.value.ingress_referenced_security_group_id, var.defaults.ingress_referenced_security_group_id, {})
  ingress_rules                        = try(each.value.ingress_rules, var.defaults.ingress_rules, {})
  name                                 = try(each.value.name, var.defaults.name, "")
  preset_ingress_rules = try(each.value.preset_ingress_rules, var.defaults.preset_ingress_rules, {
    rabbitmq-amqp = {
      from_port   = 5672
      to_port     = 5672
      ip_protocol = "tcp"
      description = "RabbitMQ AMQP"
    }
    rabbitmq-amqp-tls = {
      from_port   = 5671
      to_port     = 5671
      ip_protocol = "tcp"
      description = "RabbitMQ AMQP TLS"
    }
    rabbitmq-epmd = {
      from_port   = 4369
      to_port     = 4369
      ip_protocol = "tcp"
      description = "RabbitMQ epmd"
    }
    rabbitmq-internode = {
      from_port   = 25672
      to_port     = 25672
      ip_protocol = "tcp"
      description = "RabbitMQ internode/CLI"
    }
    rabbitmq-management = {
      from_port   = 15672
      to_port     = 15672
      ip_protocol = "tcp"
      description = "RabbitMQ management"
    }
    rabbitmq-management-tls = {
      from_port   = 15671
      to_port     = 15671
      ip_protocol = "tcp"
      description = "RabbitMQ management TLS"
    }
  })
  region                 = try(each.value.region, var.defaults.region, null)
  revoke_rules_on_delete = try(each.value.revoke_rules_on_delete, var.defaults.revoke_rules_on_delete, false)
  tags                   = try(each.value.tags, var.defaults.tags, {})
  timeouts               = try(each.value.timeouts, var.defaults.timeouts, null)
  use_name_prefix        = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
  vpc_associations       = try(each.value.vpc_associations, var.defaults.vpc_associations, {})
  vpc_id                 = try(each.value.vpc_id, var.defaults.vpc_id, null)
}
