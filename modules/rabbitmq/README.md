# rabbitmq - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "rabbitmq_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/rabbitmq"

  # omitted...
}
```

All automatic values **rabbitmq module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/rabbitmq/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto\_computed\_egress\_rules | List of computed egress rules to add automatically | list | `[]` | no |
| auto\_computed\_egress\_with\_self | List of maps defining computed egress rules with self to add automatically | list | `[]` | no |
| auto\_computed\_ingress\_rules | List of ingress rules to add automatically | list | `[]` | no |
| auto\_computed\_ingress\_with\_self | List of maps defining computed ingress rules with self to add automatically | list | `[]` | no |
| auto\_egress\_rules | List of egress rules to add automatically | list | `[ "all-all" ]` | no |
| auto\_egress\_with\_self | List of maps defining egress rules with self to add automatically | list | `[]` | no |
| auto\_ingress\_rules | List of ingress rules to add automatically | list | `[ "rabbitmq-4369-tcp", "rabbitmq-5671-tcp", "rabbitmq-5672-tcp", "rabbitmq-15672-tcp", "rabbitmq-25672-tcp" ]` | no |
| auto\_ingress\_with\_self | List of maps defining ingress rules with self to add automatically | list | `[ { "rule": "all-all" } ]` | no |
| auto\_number\_of\_computed\_egress\_rules | Number of computed egress rules to create by name | string | `"0"` | no |
| auto\_number\_of\_computed\_egress\_with\_self | Number of computed egress rules to create where 'self' is defined | string | `"0"` | no |
| auto\_number\_of\_computed\_ingress\_rules | Number of computed ingress rules to create by name | string | `"0"` | no |
| auto\_number\_of\_computed\_ingress\_with\_self | Number of computed ingress rules to create where 'self' is defined | string | `"0"` | no |
| computed\_egress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all computed egress rules | list | `[ "0.0.0.0/0" ]` | no |
| computed\_egress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all computed egress rules | list | `[ "::/0" ]` | no |
| computed\_egress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all computed egress rules | list | `[]` | no |
| computed\_egress\_rules | List of computed egress rules to create by name | list | `[]` | no |
| computed\_egress\_with\_cidr\_blocks | List of computed egress rules to create where 'cidr_blocks' is used | list | `[]` | no |
| computed\_egress\_with\_ipv6\_cidr\_blocks | List of computed egress rules to create where 'ipv6_cidr_blocks' is used | list | `[]` | no |
| computed\_egress\_with\_self | List of computed egress rules to create where 'self' is defined | list | `[]` | no |
| computed\_egress\_with\_source\_security\_group\_id | List of computed egress rules to create where 'source_security_group_id' is used | list | `[]` | no |
| computed\_ingress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all computed ingress rules | list | `[]` | no |
| computed\_ingress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all computed ingress rules | list | `[]` | no |
| computed\_ingress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all computed ingress rules | list | `[]` | no |
| computed\_ingress\_rules | List of computed ingress rules to create by name | list | `[]` | no |
| computed\_ingress\_with\_cidr\_blocks | List of computed ingress rules to create where 'cidr_blocks' is used | list | `[]` | no |
| computed\_ingress\_with\_ipv6\_cidr\_blocks | List of computed ingress rules to create where 'ipv6_cidr_blocks' is used | list | `[]` | no |
| computed\_ingress\_with\_self | List of computed ingress rules to create where 'self' is defined | list | `[]` | no |
| computed\_ingress\_with\_source\_security\_group\_id | List of computed ingress rules to create where 'source_security_group_id' is used | list | `[]` | no |
| create | Whether to create security group and all rules | string | `"true"` | no |
| description | Description of security group | string | `"Security Group managed by Terraform"` | no |
| egress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all egress rules | list | `[ "0.0.0.0/0" ]` | no |
| egress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all egress rules | list | `[ "::/0" ]` | no |
| egress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | list | `[]` | no |
| egress\_rules | List of egress rules to create by name | list | `[]` | no |
| egress\_with\_cidr\_blocks | List of egress rules to create where 'cidr_blocks' is used | list | `[]` | no |
| egress\_with\_ipv6\_cidr\_blocks | List of egress rules to create where 'ipv6_cidr_blocks' is used | list | `[]` | no |
| egress\_with\_self | List of egress rules to create where 'self' is defined | list | `[]` | no |
| egress\_with\_source\_security\_group\_id | List of egress rules to create where 'source_security_group_id' is used | list | `[]` | no |
| ingress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all ingress rules | list | `[]` | no |
| ingress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all ingress rules | list | `[]` | no |
| ingress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | list | `[]` | no |
| ingress\_rules | List of ingress rules to create by name | list | `[]` | no |
| ingress\_with\_cidr\_blocks | List of ingress rules to create where 'cidr_blocks' is used | list | `[]` | no |
| ingress\_with\_ipv6\_cidr\_blocks | List of ingress rules to create where 'ipv6_cidr_blocks' is used | list | `[]` | no |
| ingress\_with\_self | List of ingress rules to create where 'self' is defined | list | `[]` | no |
| ingress\_with\_source\_security\_group\_id | List of ingress rules to create where 'source_security_group_id' is used | list | `[]` | no |
| name | Name of security group | string | n/a | yes |
| number\_of\_computed\_egress\_cidr\_blocks | Number of IPv4 CIDR ranges to use on all computed egress rules | string | `"0"` | no |
| number\_of\_computed\_egress\_ipv6\_cidr\_blocks | Number of IPv6 CIDR ranges to use on all computed egress rules | string | `"0"` | no |
| number\_of\_computed\_egress\_prefix\_list\_ids | Number of prefix list IDs (for allowing access to VPC endpoints) to use on all computed egress rules | string | `"0"` | no |
| number\_of\_computed\_egress\_rules | Number of computed egress rules to create by name | string | `"0"` | no |
| number\_of\_computed\_egress\_with\_cidr\_blocks | Number of computed egress rules to create where 'cidr_blocks' is used | string | `"0"` | no |
| number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks | Number of computed egress rules to create where 'ipv6_cidr_blocks' is used | string | `"0"` | no |
| number\_of\_computed\_egress\_with\_self | Number of computed egress rules to create where 'self' is defined | string | `"0"` | no |
| number\_of\_computed\_egress\_with\_source\_security\_group\_id | Number of computed egress rules to create where 'source_security_group_id' is used | string | `"0"` | no |
| number\_of\_computed\_ingress\_cidr\_blocks | Number of IPv4 CIDR ranges to use on all computed ingress rules | string | `"0"` | no |
| number\_of\_computed\_ingress\_ipv6\_cidr\_blocks | Number of IPv6 CIDR ranges to use on all computed ingress rules | string | `"0"` | no |
| number\_of\_computed\_ingress\_prefix\_list\_ids | Number of prefix list IDs (for allowing access to VPC endpoints) to use on all computed ingress rules | string | `"0"` | no |
| number\_of\_computed\_ingress\_rules | Number of computed ingress rules to create by name | string | `"0"` | no |
| number\_of\_computed\_ingress\_with\_cidr\_blocks | Number of computed ingress rules to create where 'cidr_blocks' is used | string | `"0"` | no |
| number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks | Number of computed ingress rules to create where 'ipv6_cidr_blocks' is used | string | `"0"` | no |
| number\_of\_computed\_ingress\_with\_self | Number of computed ingress rules to create where 'self' is defined | string | `"0"` | no |
| number\_of\_computed\_ingress\_with\_source\_security\_group\_id | Number of computed ingress rules to create where 'source_security_group_id' is used | string | `"0"` | no |
| tags | A mapping of tags to assign to security group | map | `{}` | no |
| use\_name\_prefix | Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation | string | `"true"` | no |
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
