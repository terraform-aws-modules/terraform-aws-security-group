module "wrapper" {
  source = "../../modules/wazuh"

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
    wazuh-agent-cluster-daemon = {
      from_port   = 1516
      to_port     = 1516
      ip_protocol = "tcp"
      description = "Wazuh cluster daemon"
    }
    wazuh-agent-connection-tcp = {
      from_port   = 1514
      to_port     = 1514
      ip_protocol = "tcp"
      description = "Agent connection (TCP)"
    }
    wazuh-agent-connection-udp = {
      from_port   = 1514
      to_port     = 1514
      ip_protocol = "udp"
      description = "Agent connection (UDP)"
    }
    wazuh-agent-enrollment = {
      from_port   = 1515
      to_port     = 1515
      ip_protocol = "tcp"
      description = "Agent enrollment service"
    }
    wazuh-dashboard = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "Wazuh web user interface"
    }
    wazuh-indexer-restful-api = {
      from_port   = 9200
      to_port     = 9200
      ip_protocol = "tcp"
      description = "Wazuh indexer RESTful API"
    }
    wazuh-restful-api = {
      from_port   = 55000
      to_port     = 55000
      ip_protocol = "tcp"
      description = "Wazuh server RESTful API"
    }
    wazuh-syslog-collector-tcp = {
      from_port   = 514
      to_port     = 514
      ip_protocol = "tcp"
      description = "Wazuh Syslog collector (TCP)"
    }
    wazuh-syslog-collector-udp = {
      from_port   = 514
      to_port     = 514
      ip_protocol = "udp"
      description = "Wazuh Syslog collector (UDP)"
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
