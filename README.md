AWS EC2-VPC Security Group Terraform module
===========================================

Terraform module which creates [EC2 security group within VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) on AWS.

These types of resources are supported:

* [EC2-VPC Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* [EC2-VPC Security Group Rules](https://www.terraform.io/docs/providers/aws/r/security_group_rule.html)

Root module creates security group with provided arguments.

Modules in [modules directory](modules) has been configured with the list of ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](modules/ssh), [http](modules/http), [mysql](modules/mysql)).

Code in this module aims to implement **ALL** combinations of arguments (IPV4/IPV6 CIDR blocks, [VPC endpoint prefix lists](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html), source security groups, self), named rules.

If there is something missing - [open an issue](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/new).

Usage
-----

There are two ways to create security groups using this module:

##### 1. Security group with pre-defined rules

```hcl
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

##### 2. Security group with custom rules

```hcl
module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["mysql"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = 6
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgres"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
```

Parameters
----------

Ingress and egress rules can be configured in a variety of ways as listed on [the registry](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/?tab=inputs).

Examples
--------

* [Complete Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete)
* [HTTP Security Group example](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/http)

Authors
-------

Module managed by [Anton Babenko](https://github.com/antonbabenko).

License
-------

Apache 2 Licensed. See LICENSE for full details.