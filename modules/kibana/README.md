# kibana - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "kibana_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/kibana"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **kibana module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/kibana/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.42 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sg"></a> [sg](#module\_sg) | ../../ |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_computed_egress_rules"></a> [auto\_computed\_egress\_rules](#input\_auto\_computed\_egress\_rules) | List of computed egress rules to add automatically | `list(string)` | `[]` | no |
| <a name="input_auto_computed_egress_with_self"></a> [auto\_computed\_egress\_with\_self](#input\_auto\_computed\_egress\_with\_self) | List of maps defining computed egress rules with self to add automatically | `list(map(string))` | `[]` | no |
| <a name="input_auto_computed_ingress_rules"></a> [auto\_computed\_ingress\_rules](#input\_auto\_computed\_ingress\_rules) | List of ingress rules to add automatically | `list(string)` | `[]` | no |
| <a name="input_auto_computed_ingress_with_self"></a> [auto\_computed\_ingress\_with\_self](#input\_auto\_computed\_ingress\_with\_self) | List of maps defining computed ingress rules with self to add automatically | `list(map(string))` | `[]` | no |
| <a name="input_auto_egress_rules"></a> [auto\_egress\_rules](#input\_auto\_egress\_rules) | List of egress rules to add automatically | `list(string)` | <pre>[<br>  "all-all"<br>]</pre> | no |
| <a name="input_auto_egress_with_self"></a> [auto\_egress\_with\_self](#input\_auto\_egress\_with\_self) | List of maps defining egress rules with self to add automatically | `list(map(string))` | `[]` | no |
| <a name="input_auto_ingress_rules"></a> [auto\_ingress\_rules](#input\_auto\_ingress\_rules) | List of ingress rules to add automatically | `list(string)` | <pre>[<br>  "kibana-tcp"<br>]</pre> | no |
| <a name="input_auto_ingress_with_self"></a> [auto\_ingress\_with\_self](#input\_auto\_ingress\_with\_self) | List of maps defining ingress rules with self to add automatically | `list(map(string))` | <pre>[<br>  {<br>    "rule": "all-all"<br>  }<br>]</pre> | no |
| <a name="input_auto_number_of_computed_egress_rules"></a> [auto\_number\_of\_computed\_egress\_rules](#input\_auto\_number\_of\_computed\_egress\_rules) | Number of computed egress rules to create by name | `number` | `0` | no |
| <a name="input_auto_number_of_computed_egress_with_self"></a> [auto\_number\_of\_computed\_egress\_with\_self](#input\_auto\_number\_of\_computed\_egress\_with\_self) | Number of computed egress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_auto_number_of_computed_ingress_rules"></a> [auto\_number\_of\_computed\_ingress\_rules](#input\_auto\_number\_of\_computed\_ingress\_rules) | Number of computed ingress rules to create by name | `number` | `0` | no |
| <a name="input_auto_number_of_computed_ingress_with_self"></a> [auto\_number\_of\_computed\_ingress\_with\_self](#input\_auto\_number\_of\_computed\_ingress\_with\_self) | Number of computed ingress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_computed_egress_cidr_blocks"></a> [computed\_egress\_cidr\_blocks](#input\_computed\_egress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all computed egress rules | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_computed_egress_ipv6_cidr_blocks"></a> [computed\_egress\_ipv6\_cidr\_blocks](#input\_computed\_egress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all computed egress rules | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_computed_egress_prefix_list_ids"></a> [computed\_egress\_prefix\_list\_ids](#input\_computed\_egress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all computed egress rules | `list(string)` | `[]` | no |
| <a name="input_computed_egress_rules"></a> [computed\_egress\_rules](#input\_computed\_egress\_rules) | List of computed egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_egress_with_cidr_blocks"></a> [computed\_egress\_with\_cidr\_blocks](#input\_computed\_egress\_with\_cidr\_blocks) | List of computed egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_ipv6_cidr_blocks"></a> [computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_computed\_egress\_with\_ipv6\_cidr\_blocks) | List of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_self"></a> [computed\_egress\_with\_self](#input\_computed\_egress\_with\_self) | List of computed egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_source_security_group_id"></a> [computed\_egress\_with\_source\_security\_group\_id](#input\_computed\_egress\_with\_source\_security\_group\_id) | List of computed egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_cidr_blocks"></a> [computed\_ingress\_cidr\_blocks](#input\_computed\_ingress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all computed ingress rules | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_ipv6_cidr_blocks"></a> [computed\_ingress\_ipv6\_cidr\_blocks](#input\_computed\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all computed ingress rules | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_prefix_list_ids"></a> [computed\_ingress\_prefix\_list\_ids](#input\_computed\_ingress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all computed ingress rules | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_rules"></a> [computed\_ingress\_rules](#input\_computed\_ingress\_rules) | List of computed ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_with_cidr_blocks"></a> [computed\_ingress\_with\_cidr\_blocks](#input\_computed\_ingress\_with\_cidr\_blocks) | List of computed ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_ipv6_cidr_blocks"></a> [computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | List of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_self"></a> [computed\_ingress\_with\_self](#input\_computed\_ingress\_with\_self) | List of computed ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_source_security_group_id"></a> [computed\_ingress\_with\_source\_security\_group\_id](#input\_computed\_ingress\_with\_source\_security\_group\_id) | List of computed ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create security group and all rules | `bool` | `true` | no |
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
| <a name="input_name"></a> [name](#input\_name) | Name of security group | `string` | n/a | yes |
| <a name="input_number_of_computed_egress_cidr_blocks"></a> [number\_of\_computed\_egress\_cidr\_blocks](#input\_number\_of\_computed\_egress\_cidr\_blocks) | Number of IPv4 CIDR ranges to use on all computed egress rules | `number` | `0` | no |
| <a name="input_number_of_computed_egress_ipv6_cidr_blocks"></a> [number\_of\_computed\_egress\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_egress\_ipv6\_cidr\_blocks) | Number of IPv6 CIDR ranges to use on all computed egress rules | `number` | `0` | no |
| <a name="input_number_of_computed_egress_prefix_list_ids"></a> [number\_of\_computed\_egress\_prefix\_list\_ids](#input\_number\_of\_computed\_egress\_prefix\_list\_ids) | Number of prefix list IDs (for allowing access to VPC endpoints) to use on all computed egress rules | `number` | `0` | no |
| <a name="input_number_of_computed_egress_rules"></a> [number\_of\_computed\_egress\_rules](#input\_number\_of\_computed\_egress\_rules) | Number of computed egress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_cidr\_blocks) | Number of computed egress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks) | Number of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_self"></a> [number\_of\_computed\_egress\_with\_self](#input\_number\_of\_computed\_egress\_with\_self) | Number of computed egress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_source_security_group_id"></a> [number\_of\_computed\_egress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_egress\_with\_source\_security\_group\_id) | Number of computed egress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_cidr_blocks"></a> [number\_of\_computed\_ingress\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_cidr\_blocks) | Number of IPv4 CIDR ranges to use on all computed ingress rules | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_ipv6_cidr_blocks"></a> [number\_of\_computed\_ingress\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_ipv6\_cidr\_blocks) | Number of IPv6 CIDR ranges to use on all computed ingress rules | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_prefix_list_ids"></a> [number\_of\_computed\_ingress\_prefix\_list\_ids](#input\_number\_of\_computed\_ingress\_prefix\_list\_ids) | Number of prefix list IDs (for allowing access to VPC endpoints) to use on all computed ingress rules | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_rules"></a> [number\_of\_computed\_ingress\_rules](#input\_number\_of\_computed\_ingress\_rules) | Number of computed ingress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_cidr\_blocks) | Number of computed ingress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | Number of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_self"></a> [number\_of\_computed\_ingress\_with\_self](#input\_number\_of\_computed\_ingress\_with\_self) | Number of computed ingress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_source_security_group_id"></a> [number\_of\_computed\_ingress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id) | Number of computed ingress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to security group | `map(string)` | `{}` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Whether to use name\_prefix or fixed name. Should be true to able to update security group name after initial creation | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
