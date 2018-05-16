# elasticsearch - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "elasticsearch_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/elasticsearch"

  # omitted...
}
```

All automatic values **elasticsearch module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/elasticsearch/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto_egress_rules | List of egress rules to add automatically | list | `<list>` | no |
| auto_egress_with_self | List of maps defining egress rules with self to add automatically | list | `<list>` | no |
| auto_ingress_rules | List of ingress rules to add automatically | list | `<list>` | no |
| auto_ingress_with_self | List of maps defining ingress rules with self to add automatically | list | `<list>` | no |
| create | Whether to create security group and all rules | string | `true` | no |
| description | Description of security group | string | `Security Group managed by Terraform` | no |
| egress_cidr_blocks | List of IPv4 CIDR ranges to use on all egress rules | string | `<list>` | no |
| egress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all egress rules | string | `<list>` | no |
| egress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | string | `<list>` | no |
| egress_rules | List of egress rules to create by name | string | `<list>` | no |
| egress_with_cidr_blocks | List of egress rules to create where 'cidr_blocks' is used | string | `<list>` | no |
| egress_with_ipv6_cidr_blocks | List of egress rules to create where 'ipv6_cidr_blocks' is used | string | `<list>` | no |
| egress_with_self | List of egress rules to create where 'self' is defined | string | `<list>` | no |
| egress_with_source_security_group_id | List of egress rules to create where 'source_security_group_id' is used | string | `<list>` | no |
| ingress_cidr_blocks | List of IPv4 CIDR ranges to use on all ingress rules | string | `<list>` | no |
| ingress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all ingress rules | string | `<list>` | no |
| ingress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | string | `<list>` | no |
| ingress_rules | List of ingress rules to create by name | string | `<list>` | no |
| ingress_with_cidr_blocks | List of ingress rules to create where 'cidr_blocks' is used | string | `<list>` | no |
| ingress_with_ipv6_cidr_blocks | List of ingress rules to create where 'ipv6_cidr_blocks' is used | string | `<list>` | no |
| ingress_with_self | List of ingress rules to create where 'self' is defined | string | `<list>` | no |
| ingress_with_source_security_group_id | List of ingress rules to create where 'source_security_group_id' is used | string | `<list>` | no |
| name | Name of security group | string | - | yes |
| tags | A mapping of tags to assign to security group | string | `<map>` | no |
| vpc_id | ID of the VPC where to create security group | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| this_security_group_description | The description of the security group |
| this_security_group_id | The ID of the security group |
| this_security_group_name | The name of the security group |
| this_security_group_owner_id | The owner ID |
| this_security_group_vpc_id | The VPC ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
