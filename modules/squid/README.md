# AWS Squid Security Group Terraform Module

Terraform module which creates a pre-configured AWS security group for Squid.

## Usage

```hcl
module "squid_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/squid"
  version = "~> 6.0"

  name        = "squid"
  description = "Security group for squid"
  vpc_id      = "vpc-xxxxxxxx"

  ingress_cidr_ipv4 = {
    vpc = "10.0.0.0/16"
  }
}
```

## Preset ingress rules

| Rule | From port | To port | Protocol | Description |
| ---- | --------- | ------- | -------- | ----------- |
| `squid` | 3128 | 3128 | `tcp` | Squid default proxy |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.29 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | Security group egress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_exclusive_rules"></a> [enable\_exclusive\_rules](#input\_enable\_exclusive\_rules) | Whether to enforce that only the rules declared by this module exist on the security group. When true, out-of-band rules added via the AWS console or other Terraform configurations will be reverted on next apply | `bool` | `true` | no |
| <a name="input_ingress_cidr_ipv4"></a> [ingress\_cidr\_ipv4](#input\_ingress\_cidr\_ipv4) | Map of IPv4 CIDRs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the CIDRs. Each entry produces one ingress rule per preset rule | `map(string)` | `{}` | no |
| <a name="input_ingress_cidr_ipv6"></a> [ingress\_cidr\_ipv6](#input\_ingress\_cidr\_ipv6) | Map of IPv6 CIDRs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the CIDRs. Each entry produces one ingress rule per preset rule | `map(string)` | `{}` | no |
| <a name="input_ingress_prefix_list_id"></a> [ingress\_prefix\_list\_id](#input\_ingress\_prefix\_list\_id) | Map of prefix list IDs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the prefix list IDs. Each entry produces one ingress rule per preset rule | `map(string)` | `{}` | no |
| <a name="input_ingress_referenced_security_group_id"></a> [ingress\_referenced\_security\_group\_id](#input\_ingress\_referenced\_security\_group\_id) | Map of source security group IDs to apply across the preset ingress rules. Map keys are user-supplied identifiers; values are the security group IDs. Use `self` as a value to reference the security group created by this module. Each entry produces one ingress rule per preset rule | `map(string)` | `{}` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Additional security group ingress rules to merge with the preset rules | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of security group | `string` | `""` | no |
| <a name="input_preset_ingress_rules"></a> [preset\_ingress\_rules](#input\_preset\_ingress\_rules) | Preset ingress rule definitions for this service. Defaults to the curated catalog set; pass `{}` to disable, or override individual entries | <pre>map(object({<br/>    from_port   = number<br/>    to_port     = number<br/>    ip_protocol = string<br/>    description = optional(string)<br/>  }))</pre> | <pre>{<br/>  "squid": {<br/>    "description": "Squid default proxy",<br/>    "from_port": 3128,<br/>    "ip_protocol": "tcp",<br/>    "to_port": 3128<br/>  }<br/>}</pre> | no |
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

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/LICENSE) for full details.
