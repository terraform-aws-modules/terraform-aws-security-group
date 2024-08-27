# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = ["consul-tcp", "consul-grpc-tcp", "consul-grpc-tcp-tls", "consul-webui-http-tcp", "consul-webui-https-tcp", "consul-dns-tcp", "consul-dns-udp", "consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-serf-wan-tcp", "consul-serf-wan-udp"]
}

variable "auto_ingress_with_self" {
  description = "List of maps defining ingress rules with self to add automatically"
  type        = list(map(string))
  default     = [{ "rule" = "all-all" }]
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = ["all-all"]
}

variable "auto_egress_with_self" {
  description = "List of maps defining egress rules with self to add automatically"
  type        = list(map(string))
  default     = []
}
