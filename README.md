# AWS Security Group Terraform module

Terraform module which creates [EC2 security group within VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) on AWS.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

### Root module

```hcl
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "example"
  description = "Example security group"
  vpc_id      = "vpc-12345678"

  ingress_rules = {
    https = {
      from_port   = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "10.0.0.0/16"
      description = "HTTPS from internal"
    }
    self-all = {
      ip_protocol                  = "-1"
      referenced_security_group_id = "self"
      description                  = "All traffic from members of this SG"
    }
  }

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = {
    Environment = "dev"
  }
}
```

### Preset submodule

Each preset submodule under `modules/` ships a curated set of ingress rules for a specific service (PostgreSQL, Consul, Cassandra, etc.). Use one when a security group serves a single service.

```hcl
module "postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"

  name        = "postgresql"
  description = "PostgreSQL access"
  vpc_id      = "vpc-12345678"

  ingress_cidr_ipv4 = {
    vpc  = "10.0.0.0/16"
    peer = "172.16.0.0/12"
  }
}
```

## Examples

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples/complete) - Comprehensive example demonstrating the full module surface

## Notes

### Referencing the security group itself

To allow traffic between members of the security group created by this module, set `referenced_security_group_id = "self"` on the rule. The sentinel is rewritten to the security group's own id at apply time:

```hcl
ingress_rules = {
  self-all = {
    ip_protocol                  = "-1"
    referenced_security_group_id = "self"
    description                  = "All traffic from members of this SG"
  }
}
```

### `use_name_prefix` and the create-before-destroy lifecycle

The security group resource sets `lifecycle { create_before_destroy = true }` so replacements happen without dropping traffic. When `use_name_prefix = false` (i.e. you pin a static `name`), any change that forces replacement will fail because AWS cannot create a second security group with the same name in the same VPC. Either:

- keep `use_name_prefix = true` (default), or
- change `name` along with the replacement.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.29 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.29 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_rules_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_rules_exclusive) | resource |
| [aws_vpc_security_group_vpc_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_vpc_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `null` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | Map of egress rules to add to the security group | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_exclusive_rules"></a> [enable\_exclusive\_rules](#input\_enable\_exclusive\_rules) | Whether to enforce that only the rules declared by this module exist on the security group. When true, out-of-band rules added via the AWS console or other Terraform configurations will be reverted on next apply | `bool` | `true` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Map of ingress rules to add to the security group | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of security group | `string` | `""` | no |
| <a name="input_putin_khuylo"></a> [putin\_khuylo](#input\_putin\_khuylo) | Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo! | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create and delete timeout configurations for the security group | <pre>object({<br/>    create = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Whether to use the name (`name`) as a prefix, appending a random suffix | `bool` | `true` | no |
| <a name="input_vpc_associations"></a> [vpc\_associations](#input\_vpc\_associations) | Map of VPC IDs to associate the security group to | <pre>map(object({<br/>    vpc_id = string<br/>  }))</pre> | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the security group is created | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the security group |
| <a name="output_id"></a> [id](#output\_id) | The ID of the security group |
| <a name="output_name"></a> [name](#output\_name) | The name of the security group |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The owner ID |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-security-group/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/LICENSE) for full details.

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
