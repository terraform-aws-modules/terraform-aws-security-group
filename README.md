# AWS EC2-VPC Security Group Terraform module

[![Help Contribute to Open Source](https://www.codetriage.com/terraform-aws-modules/terraform-aws-security-group/badges/users.svg)](https://www.codetriage.com/terraform-aws-modules/terraform-aws-security-group)

Terraform module which creates [EC2 security group within VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) on AWS.

## Features

This module aims to implement **ALL** combinations of arguments supported by AWS and latest stable version of Terraform:
* IPv4/IPv6 CIDR blocks
* [VPC endpoint prefix lists](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html) (use data source [aws_prefix_list](https://www.terraform.io/docs/providers/aws/d/prefix_list.html))
* Access from source security groups
* Access from self
* Named rules ([see the rules here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf))
* Named groups of rules with ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/mysql), see the whole list [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/README.md))
* Conditionally create security group and/or all required security group rules.

Ingress and egress rules can be configured in a variety of ways. See [inputs section](#inputs) for all supported arguments and [complete example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete) for the complete use-case.

If there is a missing feature or a bug - [open an issue](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/new).

## Terraform versions

For Terraform 0.12 use version `v4.*` of this module or newer.

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

  vpc_id = "vpc-12345678" # these are valid values also - `module.vpc.vpc_id` and `local.vpc_id`

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.http_sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "db_computed_sg" {
  # omitted for brevity

  ingress_cidr_blocks = ["10.10.0.0/16", data.aws_security_group.default.id]

  computed_ingress_cidr_blocks           = [module.vpc.vpc_cidr_block]
  number_of_computed_ingress_cidr_blocks = 1
}

module "db_computed_merged_sg" {
  # omitted for brevity

  computed_ingress_cidr_blocks           = ["10.10.0.0/16", module.vpc.vpc_cidr_block]
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
* [Security Group "Rules Only" example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete) shows how to manage just rules of a security group that is created outside.
* [HTTP Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [Disable creation of Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/disabled) shows how to disable creation of security group.
* [Dynamic values inside Security Group rules example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/dynamic) shows how to specify values inside security group rules (data-sources and variables are allowed).
* [Computed values inside Security Group rules example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/computed) shows how to specify computed values inside security group rules (solution for `value of 'count' cannot be computed` problem).

## How to add/update rules/groups?

Rules and groups are defined in [rules.tf](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf). Run `update_groups.sh` when content of that file has changed to recreate content of all automatic modules.

## Known issues

No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.42 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.42 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.this_name_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.computed_egress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_egress_with_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_egress_with_ipv6_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_egress_with_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_egress_with_source_security_group_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_ingress_with_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_ingress_with_ipv6_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_ingress_with_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.computed_ingress_with_source_security_group_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_with_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_with_ipv6_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_with_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_with_source_security_group_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_with_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_with_ipv6_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_with_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_with_source_security_group_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_groups"></a> [auto\_groups](#input\_auto\_groups) | Map of groups of security group rules to use to generate modules (see update\_groups.sh) | `map(map(list(string)))` | <pre>{<br>  "activemq": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "activemq-5671-tcp",<br>      "activemq-8883-tcp",<br>      "activemq-61614-tcp",<br>      "activemq-61617-tcp",<br>      "activemq-61619-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "alertmanager": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "alertmanager-9093-tcp",<br>      "alertmanager-9094-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "carbon-relay-ng": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "carbon-line-in-tcp",<br>      "carbon-line-in-udp",<br>      "carbon-pickle-tcp",<br>      "carbon-pickle-udp",<br>      "carbon-gui-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "cassandra": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "cassandra-clients-tcp",<br>      "cassandra-thrift-clients-tcp",<br>      "cassandra-jmx-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "consul": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "consul-tcp",<br>      "consul-cli-rpc-tcp",<br>      "consul-webui-tcp",<br>      "consul-dns-tcp",<br>      "consul-dns-udp",<br>      "consul-serf-lan-tcp",<br>      "consul-serf-lan-udp",<br>      "consul-serf-wan-tcp",<br>      "consul-serf-wan-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "docker-swarm": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "docker-swarm-mngmt-tcp",<br>      "docker-swarm-node-tcp",<br>      "docker-swarm-node-udp",<br>      "docker-swarm-overlay-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "elasticsearch": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "elasticsearch-rest-tcp",<br>      "elasticsearch-java-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "grafana": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "grafana-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "graphite-statsd": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "graphite-webui",<br>      "graphite-2003-tcp",<br>      "graphite-2004-tcp",<br>      "graphite-2023-tcp",<br>      "graphite-2024-tcp",<br>      "graphite-8080-tcp",<br>      "graphite-8125-tcp",<br>      "graphite-8125-udp",<br>      "graphite-8126-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "http-80": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "http-80-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "http-8080": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "http-8080-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "https-443": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "https-443-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "https-8443": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "https-8443-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "ipsec-4500": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "ipsec-4500-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "ipsec-500": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "ipsec-500-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "kafka": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "kafka-broker-tcp",<br>      "kafka-broker-tls-tcp",<br>      "kafka-jmx-exporter-tcp",<br>      "kafka-node-exporter-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "kibana": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "kibana-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "kubernetes-api": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "kubernetes-api-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "ldap": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "ldap-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "ldaps": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "ldaps-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "logstash": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "logstash-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "memcached": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "memcached-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "minio": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "minio-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "mongodb": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "mongodb-27017-tcp",<br>      "mongodb-27018-tcp",<br>      "mongodb-27019-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "mssql": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "mssql-tcp",<br>      "mssql-udp",<br>      "mssql-analytics-tcp",<br>      "mssql-broker-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "mysql": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "mysql-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "nfs": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "nfs-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "nomad": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "nomad-http-tcp",<br>      "nomad-rpc-tcp",<br>      "nomad-serf-tcp",<br>      "nomad-serf-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "ntp": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "ntp-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "openvpn": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "openvpn-udp",<br>      "openvpn-tcp",<br>      "openvpn-https-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "oracle-db": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "oracle-db-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "postgresql": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "postgresql-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "prometheus": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "prometheus-http-tcp",<br>      "prometheus-pushgateway-http-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "puppet": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "puppet-tcp",<br>      "puppetdb-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "rabbitmq": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "rabbitmq-4369-tcp",<br>      "rabbitmq-5671-tcp",<br>      "rabbitmq-5672-tcp",<br>      "rabbitmq-15672-tcp",<br>      "rabbitmq-25672-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "rdp": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "rdp-tcp",<br>      "rdp-udp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "redis": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "redis-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "redshift": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "redshift-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "smtp": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "smtp-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "smtp-submission": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "smtp-submission-587-tcp",<br>      "smtp-submission-2587-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "smtps": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "smtps-465-tcp",<br>      "smtps-2465-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "solr": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "solr-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "splunk": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "splunk-indexer-tcp",<br>      "splunk-clients-tcp",<br>      "splunk-splunkd-tcp",<br>      "splunk-hec-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "squid": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "squid-proxy-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "ssh": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "ssh-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "storm": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "storm-nimbus-tcp",<br>      "storm-ui-tcp",<br>      "storm-supervisor-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "web": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "http-80-tcp",<br>      "http-8080-tcp",<br>      "https-443-tcp",<br>      "web-jmx-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "winrm": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "winrm-http-tcp",<br>      "winrm-https-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "zipkin": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "zipkin-admin-tcp",<br>      "zipkin-admin-query-tcp",<br>      "zipkin-admin-web-tcp",<br>      "zipkin-query-tcp",<br>      "zipkin-web-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  },<br>  "zookeeper": {<br>    "egress_rules": [<br>      "all-all"<br>    ],<br>    "ingress_rules": [<br>      "zookeeper-2181-tcp",<br>      "zookeeper-2888-tcp",<br>      "zookeeper-3888-tcp",<br>      "zookeeper-jmx-tcp"<br>    ],<br>    "ingress_with_self": [<br>      "all-all"<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_computed_egress_rules"></a> [computed\_egress\_rules](#input\_computed\_egress\_rules) | List of computed egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_egress_with_cidr_blocks"></a> [computed\_egress\_with\_cidr\_blocks](#input\_computed\_egress\_with\_cidr\_blocks) | List of computed egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_ipv6_cidr_blocks"></a> [computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_computed\_egress\_with\_ipv6\_cidr\_blocks) | List of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_self"></a> [computed\_egress\_with\_self](#input\_computed\_egress\_with\_self) | List of computed egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_source_security_group_id"></a> [computed\_egress\_with\_source\_security\_group\_id](#input\_computed\_egress\_with\_source\_security\_group\_id) | List of computed egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_rules"></a> [computed\_ingress\_rules](#input\_computed\_ingress\_rules) | List of computed ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_with_cidr_blocks"></a> [computed\_ingress\_with\_cidr\_blocks](#input\_computed\_ingress\_with\_cidr\_blocks) | List of computed ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_ipv6_cidr_blocks"></a> [computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | List of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_self"></a> [computed\_ingress\_with\_self](#input\_computed\_ingress\_with\_self) | List of computed ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_source_security_group_id"></a> [computed\_ingress\_with\_source\_security\_group\_id](#input\_computed\_ingress\_with\_source\_security\_group\_id) | List of computed ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create security group and all rules | `bool` | `true` | no |
| <a name="input_create_sg"></a> [create\_sg](#input\_create\_sg) | Whether to create security group | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_cidr_blocks"></a> [egress\_ipv6\_cidr\_blocks](#input\_egress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_egress_prefix_list_ids"></a> [egress\_prefix\_list\_ids](#input\_egress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | `list(string)` | `[]` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_egress_with_cidr_blocks"></a> [egress\_with\_cidr\_blocks](#input\_egress\_with\_cidr\_blocks) | List of egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_ipv6_cidr_blocks"></a> [egress\_with\_ipv6\_cidr\_blocks](#input\_egress\_with\_ipv6\_cidr\_blocks) | List of egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_self"></a> [egress\_with\_self](#input\_egress\_with\_self) | List of egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_source_security_group_id"></a> [egress\_with\_source\_security\_group\_id](#input\_egress\_with\_source\_security\_group\_id) | List of egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_ipv6_cidr_blocks"></a> [ingress\_ipv6\_cidr\_blocks](#input\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_prefix_list_ids"></a> [ingress\_prefix\_list\_ids](#input\_ingress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_ipv6_cidr_blocks"></a> [ingress\_with\_ipv6\_cidr\_blocks](#input\_ingress\_with\_ipv6\_cidr\_blocks) | List of ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_self"></a> [ingress\_with\_self](#input\_ingress\_with\_self) | List of ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_source_security_group_id"></a> [ingress\_with\_source\_security\_group\_id](#input\_ingress\_with\_source\_security\_group\_id) | List of ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of security group - not required if create\_group is false | `string` | `null` | no |
| <a name="input_number_of_computed_egress_rules"></a> [number\_of\_computed\_egress\_rules](#input\_number\_of\_computed\_egress\_rules) | Number of computed egress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_cidr\_blocks) | Number of computed egress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks) | Number of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_self"></a> [number\_of\_computed\_egress\_with\_self](#input\_number\_of\_computed\_egress\_with\_self) | Number of computed egress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_source_security_group_id"></a> [number\_of\_computed\_egress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_egress\_with\_source\_security\_group\_id) | Number of computed egress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_rules"></a> [number\_of\_computed\_ingress\_rules](#input\_number\_of\_computed\_ingress\_rules) | Number of computed ingress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_cidr\_blocks) | Number of computed ingress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | Number of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_self"></a> [number\_of\_computed\_ingress\_with\_self](#input\_number\_of\_computed\_ingress\_with\_self) | Number of computed ingress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_source_security_group_id"></a> [number\_of\_computed\_ingress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id) | Number of computed ingress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR. | `bool` | `false` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description']) | `map(list(any))` | <pre>{<br>  "_": [<br>    "",<br>    "",<br>    ""<br>  ],<br>  "activemq-5671-tcp": [<br>    5671,<br>    5671,<br>    "tcp",<br>    "ActiveMQ AMQP"<br>  ],<br>  "activemq-61614-tcp": [<br>    61614,<br>    61614,<br>    "tcp",<br>    "ActiveMQ STOMP"<br>  ],<br>  "activemq-61617-tcp": [<br>    61617,<br>    61617,<br>    "tcp",<br>    "ActiveMQ OpenWire"<br>  ],<br>  "activemq-61619-tcp": [<br>    61619,<br>    61619,<br>    "tcp",<br>    "ActiveMQ WebSocket"<br>  ],<br>  "activemq-8883-tcp": [<br>    8883,<br>    8883,<br>    "tcp",<br>    "ActiveMQ MQTT"<br>  ],<br>  "alertmanager-9093-tcp": [<br>    9093,<br>    9093,<br>    "tcp",<br>    "Alert Manager"<br>  ],<br>  "alertmanager-9094-tcp": [<br>    9094,<br>    9094,<br>    "tcp",<br>    "Alert Manager Cluster"<br>  ],<br>  "all-all": [<br>    -1,<br>    -1,<br>    "-1",<br>    "All protocols"<br>  ],<br>  "all-icmp": [<br>    -1,<br>    -1,<br>    "icmp",<br>    "All IPV4 ICMP"<br>  ],<br>  "all-ipv6-icmp": [<br>    -1,<br>    -1,<br>    58,<br>    "All IPV6 ICMP"<br>  ],<br>  "all-tcp": [<br>    0,<br>    65535,<br>    "tcp",<br>    "All TCP ports"<br>  ],<br>  "all-udp": [<br>    0,<br>    65535,<br>    "udp",<br>    "All UDP ports"<br>  ],<br>  "carbon-admin-tcp": [<br>    2004,<br>    2004,<br>    "tcp",<br>    "Carbon admin"<br>  ],<br>  "carbon-gui-udp": [<br>    8081,<br>    8081,<br>    "tcp",<br>    "Carbon GUI"<br>  ],<br>  "carbon-line-in-tcp": [<br>    2003,<br>    2003,<br>    "tcp",<br>    "Carbon line-in"<br>  ],<br>  "carbon-line-in-udp": [<br>    2003,<br>    2003,<br>    "udp",<br>    "Carbon line-in"<br>  ],<br>  "carbon-pickle-tcp": [<br>    2013,<br>    2013,<br>    "tcp",<br>    "Carbon pickle"<br>  ],<br>  "carbon-pickle-udp": [<br>    2013,<br>    2013,<br>    "udp",<br>    "Carbon pickle"<br>  ],<br>  "cassandra-clients-tcp": [<br>    9042,<br>    9042,<br>    "tcp",<br>    "Cassandra clients"<br>  ],<br>  "cassandra-jmx-tcp": [<br>    7199,<br>    7199,<br>    "tcp",<br>    "JMX"<br>  ],<br>  "cassandra-thrift-clients-tcp": [<br>    9160,<br>    9160,<br>    "tcp",<br>    "Cassandra Thrift clients"<br>  ],<br>  "consul-cli-rpc-tcp": [<br>    8400,<br>    8400,<br>    "tcp",<br>    "Consul CLI RPC"<br>  ],<br>  "consul-dns-tcp": [<br>    8600,<br>    8600,<br>    "tcp",<br>    "Consul DNS"<br>  ],<br>  "consul-dns-udp": [<br>    8600,<br>    8600,<br>    "udp",<br>    "Consul DNS"<br>  ],<br>  "consul-serf-lan-tcp": [<br>    8301,<br>    8301,<br>    "tcp",<br>    "Serf LAN"<br>  ],<br>  "consul-serf-lan-udp": [<br>    8301,<br>    8301,<br>    "udp",<br>    "Serf LAN"<br>  ],<br>  "consul-serf-wan-tcp": [<br>    8302,<br>    8302,<br>    "tcp",<br>    "Serf WAN"<br>  ],<br>  "consul-serf-wan-udp": [<br>    8302,<br>    8302,<br>    "udp",<br>    "Serf WAN"<br>  ],<br>  "consul-tcp": [<br>    8300,<br>    8300,<br>    "tcp",<br>    "Consul server"<br>  ],<br>  "consul-webui-tcp": [<br>    8500,<br>    8500,<br>    "tcp",<br>    "Consul web UI"<br>  ],<br>  "dns-tcp": [<br>    53,<br>    53,<br>    "tcp",<br>    "DNS"<br>  ],<br>  "dns-udp": [<br>    53,<br>    53,<br>    "udp",<br>    "DNS"<br>  ],<br>  "docker-swarm-mngmt-tcp": [<br>    2377,<br>    2377,<br>    "tcp",<br>    "Docker Swarm cluster management"<br>  ],<br>  "docker-swarm-node-tcp": [<br>    7946,<br>    7946,<br>    "tcp",<br>    "Docker Swarm node"<br>  ],<br>  "docker-swarm-node-udp": [<br>    7946,<br>    7946,<br>    "udp",<br>    "Docker Swarm node"<br>  ],<br>  "docker-swarm-overlay-udp": [<br>    4789,<br>    4789,<br>    "udp",<br>    "Docker Swarm Overlay Network Traffic"<br>  ],<br>  "elasticsearch-java-tcp": [<br>    9300,<br>    9300,<br>    "tcp",<br>    "Elasticsearch Java interface"<br>  ],<br>  "elasticsearch-rest-tcp": [<br>    9200,<br>    9200,<br>    "tcp",<br>    "Elasticsearch REST interface"<br>  ],<br>  "grafana-tcp": [<br>    3000,<br>    3000,<br>    "tcp",<br>    "Grafana Dashboard"<br>  ],<br>  "graphite-2003-tcp": [<br>    2003,<br>    2003,<br>    "tcp",<br>    "Carbon receiver plain text"<br>  ],<br>  "graphite-2004-tcp": [<br>    2004,<br>    2004,<br>    "tcp",<br>    "Carbon receiver pickle"<br>  ],<br>  "graphite-2023-tcp": [<br>    2023,<br>    2023,<br>    "tcp",<br>    "Carbon aggregator plaintext"<br>  ],<br>  "graphite-2024-tcp": [<br>    2024,<br>    2024,<br>    "tcp",<br>    "Carbon aggregator pickle"<br>  ],<br>  "graphite-8080-tcp": [<br>    8080,<br>    8080,<br>    "tcp",<br>    "Graphite gunicorn port"<br>  ],<br>  "graphite-8125-tcp": [<br>    8125,<br>    8125,<br>    "tcp",<br>    "Statsd TCP"<br>  ],<br>  "graphite-8125-udp": [<br>    8125,<br>    8125,<br>    "udp",<br>    "Statsd UDP default"<br>  ],<br>  "graphite-8126-tcp": [<br>    8126,<br>    8126,<br>    "tcp",<br>    "Statsd admin"<br>  ],<br>  "graphite-webui": [<br>    80,<br>    80,<br>    "tcp",<br>    "Graphite admin interface"<br>  ],<br>  "http-80-tcp": [<br>    80,<br>    80,<br>    "tcp",<br>    "HTTP"<br>  ],<br>  "http-8080-tcp": [<br>    8080,<br>    8080,<br>    "tcp",<br>    "HTTP"<br>  ],<br>  "https-443-tcp": [<br>    443,<br>    443,<br>    "tcp",<br>    "HTTPS"<br>  ],<br>  "https-8443-tcp": [<br>    8443,<br>    8443,<br>    "tcp",<br>    "HTTPS"<br>  ],<br>  "ipsec-4500-udp": [<br>    4500,<br>    4500,<br>    "udp",<br>    "IPSEC NAT-T"<br>  ],<br>  "ipsec-500-udp": [<br>    500,<br>    500,<br>    "udp",<br>    "IPSEC ISAKMP"<br>  ],<br>  "kafka-broker-tcp": [<br>    9092,<br>    9092,<br>    "tcp",<br>    "Kafka broker 0.8.2+"<br>  ],<br>  "kafka-broker-tls-tcp": [<br>    9094,<br>    9094,<br>    "tcp",<br>    "Kafka TLS enabled broker 0.8.2+"<br>  ],<br>  "kafka-jmx-exporter-tcp": [<br>    11001,<br>    11001,<br>    "tcp",<br>    "Kafka JMX Exporter"<br>  ],<br>  "kafka-node-exporter-tcp": [<br>    11002,<br>    11002,<br>    "tcp",<br>    "Kafka Node Exporter"<br>  ],<br>  "kibana-tcp": [<br>    5601,<br>    5601,<br>    "tcp",<br>    "Kibana Web Interface"<br>  ],<br>  "kubernetes-api-tcp": [<br>    6443,<br>    6443,<br>    "tcp",<br>    "Kubernetes API Server"<br>  ],<br>  "ldap-tcp": [<br>    389,<br>    389,<br>    "tcp",<br>    "LDAP"<br>  ],<br>  "ldaps-tcp": [<br>    636,<br>    636,<br>    "tcp",<br>    "LDAPS"<br>  ],<br>  "logstash-tcp": [<br>    5044,<br>    5044,<br>    "tcp",<br>    "Logstash"<br>  ],<br>  "memcached-tcp": [<br>    11211,<br>    11211,<br>    "tcp",<br>    "Memcached"<br>  ],<br>  "minio-tcp": [<br>    9000,<br>    9000,<br>    "tcp",<br>    "MinIO"<br>  ],<br>  "mongodb-27017-tcp": [<br>    27017,<br>    27017,<br>    "tcp",<br>    "MongoDB"<br>  ],<br>  "mongodb-27018-tcp": [<br>    27018,<br>    27018,<br>    "tcp",<br>    "MongoDB shard"<br>  ],<br>  "mongodb-27019-tcp": [<br>    27019,<br>    27019,<br>    "tcp",<br>    "MongoDB config server"<br>  ],<br>  "mssql-analytics-tcp": [<br>    2383,<br>    2383,<br>    "tcp",<br>    "MSSQL Analytics"<br>  ],<br>  "mssql-broker-tcp": [<br>    4022,<br>    4022,<br>    "tcp",<br>    "MSSQL Broker"<br>  ],<br>  "mssql-tcp": [<br>    1433,<br>    1433,<br>    "tcp",<br>    "MSSQL Server"<br>  ],<br>  "mssql-udp": [<br>    1434,<br>    1434,<br>    "udp",<br>    "MSSQL Browser"<br>  ],<br>  "mysql-tcp": [<br>    3306,<br>    3306,<br>    "tcp",<br>    "MySQL/Aurora"<br>  ],<br>  "nfs-tcp": [<br>    2049,<br>    2049,<br>    "tcp",<br>    "NFS/EFS"<br>  ],<br>  "nomad-http-tcp": [<br>    4646,<br>    4646,<br>    "tcp",<br>    "Nomad HTTP"<br>  ],<br>  "nomad-rpc-tcp": [<br>    4647,<br>    4647,<br>    "tcp",<br>    "Nomad RPC"<br>  ],<br>  "nomad-serf-tcp": [<br>    4648,<br>    4648,<br>    "tcp",<br>    "Serf"<br>  ],<br>  "nomad-serf-udp": [<br>    4648,<br>    4648,<br>    "udp",<br>    "Serf"<br>  ],<br>  "ntp-udp": [<br>    123,<br>    123,<br>    "udp",<br>    "NTP"<br>  ],<br>  "openvpn-https-tcp": [<br>    443,<br>    443,<br>    "tcp",<br>    "OpenVPN"<br>  ],<br>  "openvpn-tcp": [<br>    943,<br>    943,<br>    "tcp",<br>    "OpenVPN"<br>  ],<br>  "openvpn-udp": [<br>    1194,<br>    1194,<br>    "udp",<br>    "OpenVPN"<br>  ],<br>  "oracle-db-tcp": [<br>    1521,<br>    1521,<br>    "tcp",<br>    "Oracle"<br>  ],<br>  "postgresql-tcp": [<br>    5432,<br>    5432,<br>    "tcp",<br>    "PostgreSQL"<br>  ],<br>  "prometheus-http-tcp": [<br>    9090,<br>    9090,<br>    "tcp",<br>    "Prometheus"<br>  ],<br>  "prometheus-pushgateway-http-tcp": [<br>    9091,<br>    9091,<br>    "tcp",<br>    "Prometheus Pushgateway"<br>  ],<br>  "puppet-tcp": [<br>    8140,<br>    8140,<br>    "tcp",<br>    "Puppet"<br>  ],<br>  "puppetdb-tcp": [<br>    8081,<br>    8081,<br>    "tcp",<br>    "PuppetDB"<br>  ],<br>  "rabbitmq-15672-tcp": [<br>    15672,<br>    15672,<br>    "tcp",<br>    "RabbitMQ"<br>  ],<br>  "rabbitmq-25672-tcp": [<br>    25672,<br>    25672,<br>    "tcp",<br>    "RabbitMQ"<br>  ],<br>  "rabbitmq-4369-tcp": [<br>    4369,<br>    4369,<br>    "tcp",<br>    "RabbitMQ epmd"<br>  ],<br>  "rabbitmq-5671-tcp": [<br>    5671,<br>    5671,<br>    "tcp",<br>    "RabbitMQ"<br>  ],<br>  "rabbitmq-5672-tcp": [<br>    5672,<br>    5672,<br>    "tcp",<br>    "RabbitMQ"<br>  ],<br>  "rdp-tcp": [<br>    3389,<br>    3389,<br>    "tcp",<br>    "Remote Desktop"<br>  ],<br>  "rdp-udp": [<br>    3389,<br>    3389,<br>    "udp",<br>    "Remote Desktop"<br>  ],<br>  "redis-tcp": [<br>    6379,<br>    6379,<br>    "tcp",<br>    "Redis"<br>  ],<br>  "redshift-tcp": [<br>    5439,<br>    5439,<br>    "tcp",<br>    "Redshift"<br>  ],<br>  "saltstack-tcp": [<br>    4505,<br>    4506,<br>    "tcp",<br>    "SaltStack"<br>  ],<br>  "smtp-submission-2587-tcp": [<br>    2587,<br>    2587,<br>    "tcp",<br>    "SMTP Submission"<br>  ],<br>  "smtp-submission-587-tcp": [<br>    587,<br>    587,<br>    "tcp",<br>    "SMTP Submission"<br>  ],<br>  "smtp-tcp": [<br>    25,<br>    25,<br>    "tcp",<br>    "SMTP"<br>  ],<br>  "smtps-2456-tcp": [<br>    2465,<br>    2465,<br>    "tcp",<br>    "SMTPS"<br>  ],<br>  "smtps-465-tcp": [<br>    465,<br>    465,<br>    "tcp",<br>    "SMTPS"<br>  ],<br>  "solr-tcp": [<br>    8983,<br>    8987,<br>    "tcp",<br>    "Solr"<br>  ],<br>  "splunk-hec-tcp": [<br>    8088,<br>    8088,<br>    "tcp",<br>    "Splunk HEC"<br>  ],<br>  "splunk-indexer-tcp": [<br>    9997,<br>    9997,<br>    "tcp",<br>    "Splunk indexer"<br>  ],<br>  "splunk-splunkd-tcp": [<br>    8089,<br>    8089,<br>    "tcp",<br>    "Splunkd"<br>  ],<br>  "splunk-web-tcp": [<br>    8000,<br>    8000,<br>    "tcp",<br>    "Splunk Web"<br>  ],<br>  "squid-proxy-tcp": [<br>    3128,<br>    3128,<br>    "tcp",<br>    "Squid default proxy"<br>  ],<br>  "ssh-tcp": [<br>    22,<br>    22,<br>    "tcp",<br>    "SSH"<br>  ],<br>  "storm-nimbus-tcp": [<br>    6627,<br>    6627,<br>    "tcp",<br>    "Nimbus"<br>  ],<br>  "storm-supervisor-tcp": [<br>    6700,<br>    6703,<br>    "tcp",<br>    "Supervisor"<br>  ],<br>  "storm-ui-tcp": [<br>    8080,<br>    8080,<br>    "tcp",<br>    "Storm UI"<br>  ],<br>  "web-jmx-tcp": [<br>    1099,<br>    1099,<br>    "tcp",<br>    "JMX"<br>  ],<br>  "winrm-http-tcp": [<br>    5985,<br>    5985,<br>    "tcp",<br>    "WinRM HTTP"<br>  ],<br>  "winrm-https-tcp": [<br>    5986,<br>    5986,<br>    "tcp",<br>    "WinRM HTTPS"<br>  ],<br>  "zipkin-admin-query-tcp": [<br>    9901,<br>    9901,<br>    "tcp",<br>    "Zipkin Admin port query"<br>  ],<br>  "zipkin-admin-tcp": [<br>    9990,<br>    9990,<br>    "tcp",<br>    "Zipkin Admin port collector"<br>  ],<br>  "zipkin-admin-web-tcp": [<br>    9991,<br>    9991,<br>    "tcp",<br>    "Zipkin Admin port web"<br>  ],<br>  "zipkin-query-tcp": [<br>    9411,<br>    9411,<br>    "tcp",<br>    "Zipkin query port"<br>  ],<br>  "zipkin-web-tcp": [<br>    8080,<br>    8080,<br>    "tcp",<br>    "Zipkin web port"<br>  ],<br>  "zookeeper-2181-tcp": [<br>    2181,<br>    2181,<br>    "tcp",<br>    "Zookeeper"<br>  ],<br>  "zookeeper-2888-tcp": [<br>    2888,<br>    2888,<br>    "tcp",<br>    "Zookeeper"<br>  ],<br>  "zookeeper-3888-tcp": [<br>    3888,<br>    3888,<br>    "tcp",<br>    "Zookeeper"<br>  ],<br>  "zookeeper-jmx-tcp": [<br>    7199,<br>    7199,<br>    "tcp",<br>    "JMX"<br>  ]<br>}</pre> | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | ID of existing security group whose rules we will manage | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to security group | `map(string)` | `{}` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Whether to use name\_prefix or fixed name. Should be true to able to update security group name after initial creation | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
