module "wrapper" {
  source = "../../modules/consul"

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
    consul-dns-tcp = {
      from_port   = 8600
      to_port     = 8600
      ip_protocol = "tcp"
      description = "Consul DNS"
    }
    consul-dns-udp = {
      from_port   = 8600
      to_port     = 8600
      ip_protocol = "udp"
      description = "Consul DNS"
    }
    consul-grpc = {
      from_port   = 8502
      to_port     = 8502
      ip_protocol = "tcp"
      description = "Consul gRPC"
    }
    consul-grpc-tls = {
      from_port   = 8503
      to_port     = 8503
      ip_protocol = "tcp"
      description = "Consul gRPC TLS"
    }
    consul-serf-lan-tcp = {
      from_port   = 8301
      to_port     = 8301
      ip_protocol = "tcp"
      description = "Serf LAN"
    }
    consul-serf-lan-udp = {
      from_port   = 8301
      to_port     = 8301
      ip_protocol = "udp"
      description = "Serf LAN"
    }
    consul-serf-wan-tcp = {
      from_port   = 8302
      to_port     = 8302
      ip_protocol = "tcp"
      description = "Serf WAN"
    }
    consul-serf-wan-udp = {
      from_port   = 8302
      to_port     = 8302
      ip_protocol = "udp"
      description = "Serf WAN"
    }
    consul-server = {
      from_port   = 8300
      to_port     = 8300
      ip_protocol = "tcp"
      description = "Consul server"
    }
    consul-webui-http = {
      from_port   = 8500
      to_port     = 8500
      ip_protocol = "tcp"
      description = "Consul web UI HTTP"
    }
    consul-webui-https = {
      from_port   = 8501
      to_port     = 8501
      ip_protocol = "tcp"
      description = "Consul web UI HTTPS"
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
