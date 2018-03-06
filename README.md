AWS EC2-VPC Security Group Terraform module
===========================================

[![Help Contribute to Open Source](https://www.codetriage.com/terraform-aws-modules/terraform-aws-security-group/badges/users.svg)](https://www.codetriage.com/terraform-aws-modules/terraform-aws-security-group)


Terraform module which creates [EC2 security group within VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) on AWS.

These types of resources are supported:

* [EC2-VPC Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* [EC2-VPC Security Group Rule](https://www.terraform.io/docs/providers/aws/r/security_group_rule.html)

Features
--------
This module aims to implement **ALL** combinations of arguments supported by AWS and latest stable version of Terraform:
* IPv4/IPv6 CIDR blocks
* [VPC endpoint prefix lists](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html) (use data source [aws_prefix_list](https://www.terraform.io/docs/providers/aws/d/prefix_list.html))
* Access from source security groups
* Access from self
* Named rules ([see the rules here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf))
* Named groups of rules with ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/mysql), see the whole list [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/README.md))
* Conditionally create security group and all required security group rules ("single boolean switch").

Ingress and egress rules can be configured in a variety of ways as listed on [the registry documentation](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/?tab=inputs).

If there is a missing feature or a bug - [open an issue](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/new).

Usage
-----

There are two ways to create security groups using this module:

##### 1. Security group with custom rules

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

**Note:** it is not possible to use variable outputs from this module or other modules that contain calculated values when defining the security group resources. This is typically an issue when specifying either `ingress_with_source_security_group_id` or `egress_with_source_security_group_id` parameters and attempting to use the security group id of a resource which has not yet been created. However referencing variables that are already "hard-coded" in the .tf file (i.e. not calculated values dependent on the infrastructure being created) are fine. E.g. the VPC cidr block `"10.10.0.0/16"`. Also using data sources allows the use of external data/variables that are known at plan time and not regarded as calculated. More details [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/16).

##### 2. Security group with pre-defined rules (NOTE: Terraform should be version 0.11 or newer)

```hcl
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

Conditional creation
--------------------

Sometimes you need to have a way to create security group conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create`.

```hcl
# This security group will not be created
module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  create = false
  # ... omitted
}
```

Examples
--------

* [Complete Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete) shows all available parameters to configure security group.
* [HTTP Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [Disable creation of Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/disabled) shows how to disable creation of security group.

How to add/update rules/groups?
-------------------------------

Rules and groups are defined in [rules.tf](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf). Run `update_groups.sh` when content of that file has changed to recreate content of all automatic modules.

Known issues
------------

* Due to an [issue #1920](https://github.com/terraform-providers/terraform-provider-aws/issues/1920) in AWS provider, updates to the `description` of security group rules are ignored by this module. If you need to update `description` after the security group has been created you need to recreate security group rule.

Authors
-------

Module managed by [Anton Babenko](https://github.com/antonbabenko).

License
-------

Apache 2 Licensed. See LICENSE for full details.
