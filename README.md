# AWS EC2-VPC Security Group Terraform module

[![Help Contribute to Open Source](https://www.codetriage.com/terraform-aws-modules/terraform-aws-security-group/badges/users.svg)](https://www.codetriage.com/terraform-aws-modules/terraform-aws-security-group)

Terraform module which creates [EC2 security group within VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) on AWS.

These types of resources are supported:

* [EC2-VPC Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* [EC2-VPC Security Group Rule](https://www.terraform.io/docs/providers/aws/r/security_group_rule.html)

## Features

This module aims to implement **ALL** combinations of arguments supported by AWS and latest stable version of Terraform:
* IPv4/IPv6 CIDR blocks
* [VPC endpoint prefix lists](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html) (use data source [aws_prefix_list](https://www.terraform.io/docs/providers/aws/d/prefix_list.html))
* Access from source security groups
* Access from self
* Named rules ([see the rules here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf))
* Named groups of rules with ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/mysql), see the whole list [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/README.md))
* Conditionally create security group and all required security group rules ("single boolean switch").

Ingress and egress rules can be configured in a variety of ways. See [inputs section](#inputs) for all supported arguments and [complete example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete) for the complete use-case.

If there is a missing feature or a bug - [open an issue](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/new).

## Terraform versions

For Terraform 0.12 use version `v3.*` of this module.

If you are using Terraform 0.11 you can use versions `v2.*`.

## Usage

There are two ways to create security groups using this module:

1. [Specifying predefined rules (HTTP, SSH, etc)](https://github.com/terraform-aws-modules/terraform-aws-security-group#security-group-with-predefined-rules)
1. [Specifying custom rules](https://github.com/terraform-aws-modules/terraform-aws-security-group#security-group-with-custom-rules)

### Security group with predefined rules

```hcl
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

### Security group with custom rules

```hcl
module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
```

### Note about "value of 'count' cannot be computed"

Terraform 0.11 has a limitation which does not allow **computed** values inside `count` attribute on resources (issues: [#16712](https://github.com/hashicorp/terraform/issues/16712), [#18015](https://github.com/hashicorp/terraform/issues/18015), ...)

Computed values are values provided as outputs from `module`. Non-computed values are all others - static values, values referenced as `variable` and from data-sources.

When you need to specify computed value inside security group rule argument you need to specify it using an argument which starts with `computed_` and provide a number of elements in the argument which starts with `number_of_computed_`. See these examples:

```hcl
module "http_sg" {
  source = "terraform-aws-modules/security-group/aws"
  # omitted for brevity
}

module "db_computed_source_sg" {
  # omitted for brevity

  vpc_id = "vpc-12345678" # these are valid values also - "${module.vpc.vpc_id}" and "${local.vpc_id}"

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "${module.http_sg.this_security_group_id}"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "db_computed_sg" {
  # omitted for brevity

  ingress_cidr_blocks = ["10.10.0.0/16", "${data.aws_security_group.default.id}"]

  computed_ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
  number_of_computed_ingress_cidr_blocks = 1
}

module "db_computed_merged_sg" {
  # omitted for brevity

  computed_ingress_cidr_blocks = ["10.10.0.0/16", "${module.vpc.vpc_cidr_block}"]
  number_of_computed_ingress_cidr_blocks = 2
}
```

Note that `db_computed_sg` and `db_computed_merged_sg` are equal, because it is possible to put both computed and non-computed values in arguments starting with `computed_`.

## Conditional creation

Sometimes you need to have a way to create security group conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create`.

```hcl
# This security group will not be created
module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  create = false
  # ... omitted
}
```

## Examples

* [Complete Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete) shows all available parameters to configure security group.
* [HTTP Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [Disable creation of Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/disabled) shows how to disable creation of security group.
* [Dynamic values inside Security Group rules example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/dynamic) shows how to specify values inside security group rules (data-sources and variables are allowed).
* [Computed values inside Security Group rules example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/computed) shows how to specify computed values inside security group rules (solution for `value of 'count' cannot be computed` problem).

## How to add/update rules/groups?

Rules and groups are defined in [rules.tf](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf). Run `update_groups.sh` when content of that file has changed to recreate content of all automatic modules.

## Known issues

* Due to an [issue #1920](https://github.com/terraform-providers/terraform-provider-aws/issues/1920) in AWS provider, updates to the `description` of security group rules are ignored by this module. If you need to update `description` after the security group has been created you need to recreate security group rule.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto\_groups | Map of groups of security group rules to use to generate modules (see update_groups.sh) | map(map(list(string))) | `{ "carbon-relay-ng": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "carbon-line-in-tcp", "carbon-line-in-udp", "carbon-pickle-tcp", "carbon-pickle-udp", "carbon-gui-udp" ], "ingress_with_self": [ "all-all" ] } ], "cassandra": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "cassandra-clients-tcp", "cassandra-thrift-clients-tcp", "cassandra-jmx-tcp" ], "ingress_with_self": [ "all-all" ] } ], "consul": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "consul-tcp", "consul-cli-rpc-tcp", "consul-webui-tcp", "consul-dns-tcp", "consul-dns-udp", "consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-serf-wan-tcp", "consul-serf-wan-udp" ], "ingress_with_self": [ "all-all" ] } ], "docker-swarm": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "docker-swarm-mngmt-tcp", "docker-swarm-node-tcp", "docker-swarm-node-udp", "docker-swarm-overlay-udp" ], "ingress_with_self": [ "all-all" ] } ], "elasticsearch": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "elasticsearch-rest-tcp", "elasticsearch-java-tcp" ], "ingress_with_self": [ "all-all" ] } ], "http-80": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "http-80-tcp" ], "ingress_with_self": [ "all-all" ] } ], "http-8080": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "http-8080-tcp" ], "ingress_with_self": [ "all-all" ] } ], "https-443": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "https-443-tcp" ], "ingress_with_self": [ "all-all" ] } ], "https-8443": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "https-8443-tcp" ], "ingress_with_self": [ "all-all" ] } ], "ipsec-4500": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "ipsec-4500-udp" ], "ingress_with_self": [ "all-all" ] } ], "ipsec-500": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "ipsec-500-udp" ], "ingress_with_self": [ "all-all" ] } ], "kafka": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "kafka-broker-tcp" ], "ingress_with_self": [ "all-all" ] } ], "ldaps": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "ldaps-tcp" ], "ingress_with_self": [ "all-all" ] } ], "memcached": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "memcached-tcp" ], "ingress_with_self": [ "all-all" ] } ], "mongodb": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "mongodb-27017-tcp", "mongodb-27018-tcp", "mongodb-27019-tcp" ], "ingress_with_self": [ "all-all" ] } ], "mssql": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "mssql-tcp", "mssql-udp", "mssql-analytics-tcp", "mssql-broker-tcp" ], "ingress_with_self": [ "all-all" ] } ], "mysql": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "mysql-tcp" ], "ingress_with_self": [ "all-all" ] } ], "nfs": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "nfs-tcp" ], "ingress_with_self": [ "all-all" ] } ], "nomad": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "nomad-http-tcp", "nomad-rpc-tcp", "nomad-serf-tcp", "nomad-serf-udp" ], "ingress_with_self": [ "all-all" ] } ], "ntp": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "ntp-udp" ], "ingress_with_self": [ "all-all" ] } ], "openvpn": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "openvpn-udp", "openvpn-tcp", "openvpn-https-tcp" ], "ingress_with_self": [ "all-all" ] } ], "oracle-db": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "oracle-db-tcp" ], "ingress_with_self": [ "all-all" ] } ], "postgresql": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "postgresql-tcp" ], "ingress_with_self": [ "all-all" ] } ], "puppet": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "puppet-tcp", "puppetdb-tcp" ], "ingress_with_self": [ "all-all" ] } ], "rabbitmq": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "rabbitmq-4369-tcp", "rabbitmq-5671-tcp", "rabbitmq-5672-tcp", "rabbitmq-15672-tcp", "rabbitmq-25672-tcp" ], "ingress_with_self": [ "all-all" ] } ], "rdp": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "rdp-tcp", "rdp-udp" ], "ingress_with_self": [ "all-all" ] } ], "redis": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "redis-tcp" ], "ingress_with_self": [ "all-all" ] } ], "redshift": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "redshift-tcp" ], "ingress_with_self": [ "all-all" ] } ], "splunk": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "splunk-indexer-tcp", "splunk-web-tcp", "splunk-splunkd-tcp", "splunk-hec-tcp" ], "ingress_with_self": [ "all-all" ] } ], "squid": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "squid-proxy-tcp" ], "ingress_with_self": [ "all-all" ] } ], "ssh": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "ssh-tcp" ], "ingress_with_self": [ "all-all" ] } ], "storm": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "storm-nimbus-tcp", "storm-ui-tcp", "storm-supervisor-tcp" ], "ingress_with_self": [ "all-all" ] } ], "web": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "http-80-tcp", "http-8080-tcp", "https-443-tcp", "web-jmx-tcp" ], "ingress_with_self": [ "all-all" ] } ], "winrm": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "winrm-http-tcp", "winrm-https-tcp" ], "ingress_with_self": [ "all-all" ] } ], "zipkin": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "zipkin-admin-tcp", "zipkin-admin-query-tcp", "zipkin-admin-web-tcp", "zipkin-query-tcp", "zipkin-web-tcp" ], "ingress_with_self": [ "all-all" ] } ], "zookeeper": [ { "egress_rules": [ "all-all" ], "ingress_rules": [ "zookeeper-2181-tcp", "zookeeper-2888-tcp", "zookeeper-3888-tcp", "zookeeper-jmx-tcp" ], "ingress_with_self": [ "all-all" ] } ] }` | no |
| computed\_egress\_rules | List of computed egress rules to create by name | list(string) | `[]` | no |
| computed\_egress\_with\_cidr\_blocks | List of computed egress rules to create where 'cidr_blocks' is used | list(map(string)) | `[]` | no |
| computed\_egress\_with\_ipv6\_cidr\_blocks | List of computed egress rules to create where 'ipv6_cidr_blocks' is used | list(map(string)) | `[]` | no |
| computed\_egress\_with\_self | List of computed egress rules to create where 'self' is defined | list(map(string)) | `[]` | no |
| computed\_egress\_with\_source\_security\_group\_id | List of computed egress rules to create where 'source_security_group_id' is used | list(map(string)) | `[]` | no |
| computed\_ingress\_rules | List of computed ingress rules to create by name | list(string) | `[]` | no |
| computed\_ingress\_with\_cidr\_blocks | List of computed ingress rules to create where 'cidr_blocks' is used | list(map(string)) | `[]` | no |
| computed\_ingress\_with\_ipv6\_cidr\_blocks | List of computed ingress rules to create where 'ipv6_cidr_blocks' is used | list(map(string)) | `[]` | no |
| computed\_ingress\_with\_self | List of computed ingress rules to create where 'self' is defined | list(map(string)) | `[]` | no |
| computed\_ingress\_with\_source\_security\_group\_id | List of computed ingress rules to create where 'source_security_group_id' is used | list(map(string)) | `[]` | no |
| create | Whether to create security group and all rules | bool | `"true"` | no |
| description | Description of security group | string | `"Security Group managed by Terraform"` | no |
| egress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all egress rules | list(string) | `[ "0.0.0.0/0" ]` | no |
| egress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all egress rules | list(string) | `[ "::/0" ]` | no |
| egress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | list(string) | `[]` | no |
| egress\_rules | List of egress rules to create by name | list(string) | `[]` | no |
| egress\_with\_cidr\_blocks | List of egress rules to create where 'cidr_blocks' is used | list(map(string)) | `[]` | no |
| egress\_with\_ipv6\_cidr\_blocks | List of egress rules to create where 'ipv6_cidr_blocks' is used | list(map(string)) | `[]` | no |
| egress\_with\_self | List of egress rules to create where 'self' is defined | list(map(string)) | `[]` | no |
| egress\_with\_source\_security\_group\_id | List of egress rules to create where 'source_security_group_id' is used | list(map(string)) | `[]` | no |
| ingress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all ingress rules | list(string) | `[]` | no |
| ingress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all ingress rules | list(string) | `[]` | no |
| ingress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | list(string) | `[]` | no |
| ingress\_rules | List of ingress rules to create by name | list(string) | `[]` | no |
| ingress\_with\_cidr\_blocks | List of ingress rules to create where 'cidr_blocks' is used | list(map(string)) | `[]` | no |
| ingress\_with\_ipv6\_cidr\_blocks | List of ingress rules to create where 'ipv6_cidr_blocks' is used | list(map(string)) | `[]` | no |
| ingress\_with\_self | List of ingress rules to create where 'self' is defined | list(map(string)) | `[]` | no |
| ingress\_with\_source\_security\_group\_id | List of ingress rules to create where 'source_security_group_id' is used | list(map(string)) | `[]` | no |
| name | Name of security group | string | n/a | yes |
| number\_of\_computed\_egress\_rules | Number of computed egress rules to create by name | number | `"0"` | no |
| number\_of\_computed\_egress\_with\_cidr\_blocks | Number of computed egress rules to create where 'cidr_blocks' is used | number | `"0"` | no |
| number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks | Number of computed egress rules to create where 'ipv6_cidr_blocks' is used | number | `"0"` | no |
| number\_of\_computed\_egress\_with\_self | Number of computed egress rules to create where 'self' is defined | number | `"0"` | no |
| number\_of\_computed\_egress\_with\_source\_security\_group\_id | Number of computed egress rules to create where 'source_security_group_id' is used | number | `"0"` | no |
| number\_of\_computed\_ingress\_rules | Number of computed ingress rules to create by name | number | `"0"` | no |
| number\_of\_computed\_ingress\_with\_cidr\_blocks | Number of computed ingress rules to create where 'cidr_blocks' is used | number | `"0"` | no |
| number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks | Number of computed ingress rules to create where 'ipv6_cidr_blocks' is used | number | `"0"` | no |
| number\_of\_computed\_ingress\_with\_self | Number of computed ingress rules to create where 'self' is defined | number | `"0"` | no |
| number\_of\_computed\_ingress\_with\_source\_security\_group\_id | Number of computed ingress rules to create where 'source_security_group_id' is used | number | `"0"` | no |
| rules | Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description']) | map(list(any)) | `{ "_": [ "", "", "" ], "all-all": [ -1, -1, "-1", "All protocols" ], "all-icmp": [ -1, -1, "icmp", "All IPV4 ICMP" ], "all-ipv6-icmp": [ -1, -1, 58, "All IPV6 ICMP" ], "all-tcp": [ 0, 65535, "tcp", "All TCP ports" ], "all-udp": [ 0, 65535, "udp", "All UDP ports" ], "carbon-admin-tcp": [ 2004, 2004, "tcp", "Carbon admin" ], "carbon-gui-udp": [ 8081, 8081, "tcp", "Carbon GUI" ], "carbon-line-in-tcp": [ 2003, 2003, "tcp", "Carbon line-in" ], "carbon-line-in-udp": [ 2003, 2003, "udp", "Carbon line-in" ], "carbon-pickle-tcp": [ 2013, 2013, "tcp", "Carbon pickle" ], "carbon-pickle-udp": [ 2013, 2013, "udp", "Carbon pickle" ], "cassandra-clients-tcp": [ 9042, 9042, "tcp", "Cassandra clients" ], "cassandra-jmx-tcp": [ 7199, 7199, "tcp", "JMX" ], "cassandra-thrift-clients-tcp": [ 9160, 9160, "tcp", "Cassandra Thrift clients" ], "consul-cli-rpc-tcp": [ 8400, 8400, "tcp", "Consul CLI RPC" ], "consul-dns-tcp": [ 8600, 8600, "tcp", "Consul DNS" ], "consul-dns-udp": [ 8600, 8600, "udp", "Consul DNS" ], "consul-serf-lan-tcp": [ 8301, 8301, "tcp", "Serf LAN" ], "consul-serf-lan-udp": [ 8301, 8301, "udp", "Serf LAN" ], "consul-serf-wan-tcp": [ 8302, 8302, "tcp", "Serf WAN" ], "consul-serf-wan-udp": [ 8302, 8302, "udp", "Serf WAN" ], "consul-tcp": [ 8300, 8300, "tcp", "Consul server" ], "consul-webui-tcp": [ 8500, 8500, "tcp", "Consul web UI" ], "dns-tcp": [ 53, 53, "tcp", "DNS" ], "dns-udp": [ 53, 53, "udp", "DNS" ], "docker-swarm-mngmt-tcp": [ 2377, 2377, "tcp", "Docker Swarm cluster management" ], "docker-swarm-node-tcp": [ 7946, 7946, "tcp", "Docker Swarm node" ], "docker-swarm-node-udp": [ 7946, 7946, "udp", "Docker Swarm node" ], "docker-swarm-overlay-udp": [ 4789, 4789, "udp", "Docker Swarm Overlay Network Traffic" ], "elasticsearch-java-tcp": [ 9300, 9300, "tcp", "Elasticsearch Java interface" ], "elasticsearch-rest-tcp": [ 9200, 9200, "tcp", "Elasticsearch REST interface" ], "http-80-tcp": [ 80, 80, "tcp", "HTTP" ], "http-8080-tcp": [ 8080, 8080, "tcp", "HTTP" ], "https-443-tcp": [ 443, 443, "tcp", "HTTPS" ], "https-8443-tcp": [ 8443, 8443, "tcp", "HTTPS" ], "ipsec-4500-udp": [ 4500, 4500, "udp", "IPSEC NAT-T" ], "ipsec-500-udp": [ 500, 500, "udp", "IPSEC ISAKMP" ], "kafka-broker-tcp": [ 9092, 9092, "tcp", "Kafka broker 0.8.2+" ], "ldaps-tcp": [ 636, 636, "tcp", "LDAPS" ], "memcached-tcp": [ 11211, 11211, "tcp", "Memcached" ], "mongodb-27017-tcp": [ 27017, 27017, "tcp", "MongoDB" ], "mongodb-27018-tcp": [ 27018, 27018, "tcp", "MongoDB shard" ], "mongodb-27019-tcp": [ 27019, 27019, "tcp", "MongoDB config server" ], "mssql-analytics-tcp": [ 2383, 2383, "tcp", "MSSQL Analytics" ], "mssql-broker-tcp": [ 4022, 4022, "tcp", "MSSQL Broker" ], "mssql-tcp": [ 1433, 1433, "tcp", "MSSQL Server" ], "mssql-udp": [ 1434, 1434, "udp", "MSSQL Browser" ], "mysql-tcp": [ 3306, 3306, "tcp", "MySQL/Aurora" ], "nfs-tcp": [ 2049, 2049, "tcp", "NFS/EFS" ], "nomad-http-tcp": [ 4646, 4646, "tcp", "Nomad HTTP" ], "nomad-rpc-tcp": [ 4647, 4647, "tcp", "Nomad RPC" ], "nomad-serf-tcp": [ 4648, 4648, "tcp", "Serf" ], "nomad-serf-udp": [ 4648, 4648, "udp", "Serf" ], "ntp-udp": [ 123, 123, "udp", "NTP" ], "openvpn-https-tcp": [ 443, 443, "tcp", "OpenVPN" ], "openvpn-tcp": [ 943, 943, "tcp", "OpenVPN" ], "openvpn-udp": [ 1194, 1194, "udp", "OpenVPN" ], "oracle-db-tcp": [ 1521, 1521, "tcp", "Oracle" ], "postgresql-tcp": [ 5432, 5432, "tcp", "PostgreSQL" ], "puppet-tcp": [ 8140, 8140, "tcp", "Puppet" ], "puppetdb-tcp": [ 8081, 8081, "tcp", "PuppetDB" ], "rabbitmq-15672-tcp": [ 15672, 15672, "tcp", "RabbitMQ" ], "rabbitmq-25672-tcp": [ 25672, 25672, "tcp", "RabbitMQ" ], "rabbitmq-4369-tcp": [ 4369, 4369, "tcp", "RabbitMQ epmd" ], "rabbitmq-5671-tcp": [ 5671, 5671, "tcp", "RabbitMQ" ], "rabbitmq-5672-tcp": [ 5672, 5672, "tcp", "RabbitMQ" ], "rdp-tcp": [ 3389, 3389, "tcp", "Remote Desktop" ], "rdp-udp": [ 3389, 3389, "udp", "Remote Desktop" ], "redis-tcp": [ 6379, 6379, "tcp", "Redis" ], "redshift-tcp": [ 5439, 5439, "tcp", "Redshift" ], "splunk-clients-tcp": [ 8080, 8080, "tcp", "Splunk clients" ], "splunk-hec-tcp": [ 8088, 8088, "tcp", "Splunk HEC" ], "splunk-indexer-tcp": [ 9997, 9997, "tcp", "Splunk indexer" ], "splunk-splunkd-tcp": [ 8089, 8089, "tcp", "Splunkd" ], "squid-proxy-tcp": [ 3128, 3128, "tcp", "Squid default proxy" ], "ssh-tcp": [ 22, 22, "tcp", "SSH" ], "storm-nimbus-tcp": [ 6627, 6627, "tcp", "Nimbus" ], "storm-supervisor-tcp": [ 6700, 6703, "tcp", "Supervisor" ], "storm-ui-tcp": [ 8080, 8080, "tcp", "Storm UI" ], "web-jmx-tcp": [ 1099, 1099, "tcp", "JMX" ], "winrm-http-tcp": [ 5985, 5985, "tcp", "WinRM HTTP" ], "winrm-https-tcp": [ 5986, 5986, "tcp", "WinRM HTTPS" ], "zipkin-admin-query-tcp": [ 9901, 9901, "tcp", "Zipkin Admin port query" ], "zipkin-admin-tcp": [ 9990, 9990, "tcp", "Zipkin Admin port collector" ], "zipkin-admin-web-tcp": [ 9991, 9991, "tcp", "Zipkin Admin port web" ], "zipkin-query-tcp": [ 9411, 9411, "tcp", "Zipkin query port" ], "zipkin-web-tcp": [ 8080, 8080, "tcp", "Zipkin web port" ], "zookeeper-2181-tcp": [ 2181, 2181, "tcp", "Zookeeper" ], "zookeeper-2888-tcp": [ 2888, 2888, "tcp", "Zookeeper" ], "zookeeper-3888-tcp": [ 3888, 3888, "tcp", "Zookeeper" ], "zookeeper-jmx-tcp": [ 7199, 7199, "tcp", "JMX" ] }` | no |
| tags | A mapping of tags to assign to security group | map(string) | `{}` | no |
| use\_name\_prefix | Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation | bool | `"true"` | no |
| vpc\_id | ID of the VPC where to create security group | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| this\_security\_group\_description | The description of the security group |
| this\_security\_group\_id | The ID of the security group |
| this\_security\_group\_name | The name of the security group |
| this\_security\_group\_owner\_id | The owner ID |
| this\_security\_group\_vpc\_id | The VPC ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
