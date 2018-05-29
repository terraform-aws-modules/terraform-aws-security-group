# http-80 - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "http_80_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  # omitted...
}
```

All automatic values **http-80 module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/http-80/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto_computed_egress_rules | List of computed egress rules to add automatically | list | `<list>` | no |
| auto_computed_egress_with_self | List of maps defining computed egress rules with self to add automatically | list | `<list>` | no |
| auto_computed_ingress_rules | List of ingress rules to add automatically | list | `<list>` | no |
| auto_computed_ingress_with_self | List of maps defining computed ingress rules with self to add automatically | list | `<list>` | no |
| auto_egress_rules | List of egress rules to add automatically | list | `<list>` | no |
| auto_egress_with_self | List of maps defining egress rules with self to add automatically | list | `<list>` | no |
| auto_ingress_rules | List of ingress rules to add automatically | list | `<list>` | no |
| auto_ingress_with_self | List of maps defining ingress rules with self to add automatically | list | `<list>` | no |
| auto_number_of_computed_egress_rules | Number of computed egress rules to create by name | string | `0` | no |
| auto_number_of_computed_egress_with_self | Number of computed egress rules to create where 'self' is defined | string | `0` | no |
| auto_number_of_computed_ingress_rules | Number of computed ingress rules to create by name | string | `0` | no |
| auto_number_of_computed_ingress_with_self | Number of computed ingress rules to create where 'self' is defined | string | `0` | no |
| computed_egress_cidr_blocks | List of IPv4 CIDR ranges to use on all computed egress rules | string | `<list>` | no |
| computed_egress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all computed egress rules | string | `<list>` | no |
| computed_egress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all computed egress rules | string | `<list>` | no |
| computed_egress_rules | List of computed egress rules to create by name | string | `<list>` | no |
| computed_egress_with_cidr_blocks | List of computed egress rules to create where 'cidr_blocks' is used | string | `<list>` | no |
| computed_egress_with_ipv6_cidr_blocks | List of computed egress rules to create where 'ipv6_cidr_blocks' is used | string | `<list>` | no |
| computed_egress_with_self | List of computed egress rules to create where 'self' is defined | string | `<list>` | no |
| computed_egress_with_source_security_group_id | List of computed egress rules to create where 'source_security_group_id' is used | string | `<list>` | no |
| computed_ingress_cidr_blocks | List of IPv4 CIDR ranges to use on all computed ingress rules | string | `<list>` | no |
| computed_ingress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all computed ingress rules | string | `<list>` | no |
| computed_ingress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all computed ingress rules | string | `<list>` | no |
| computed_ingress_rules | List of computed ingress rules to create by name | string | `<list>` | no |
| computed_ingress_with_cidr_blocks | List of computed ingress rules to create where 'cidr_blocks' is used | string | `<list>` | no |
| computed_ingress_with_ipv6_cidr_blocks | List of computed ingress rules to create where 'ipv6_cidr_blocks' is used | string | `<list>` | no |
| computed_ingress_with_self | List of computed ingress rules to create where 'self' is defined | string | `<list>` | no |
| computed_ingress_with_source_security_group_id | List of computed ingress rules to create where 'source_security_group_id' is used | string | `<list>` | no |
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
| number_of_computed_egress_cidr_blocks | Number of IPv4 CIDR ranges to use on all computed egress rules | string | `0` | no |
| number_of_computed_egress_ipv6_cidr_blocks | Number of IPv6 CIDR ranges to use on all computed egress rules | string | `0` | no |
| number_of_computed_egress_prefix_list_ids | Number of prefix list IDs (for allowing access to VPC endpoints) to use on all computed egress rules | string | `0` | no |
| number_of_computed_egress_rules | Number of computed egress rules to create by name | string | `0` | no |
| number_of_computed_egress_with_cidr_blocks | Number of computed egress rules to create where 'cidr_blocks' is used | string | `0` | no |
| number_of_computed_egress_with_ipv6_cidr_blocks | Number of computed egress rules to create where 'ipv6_cidr_blocks' is used | string | `0` | no |
| number_of_computed_egress_with_self | Number of computed egress rules to create where 'self' is defined | string | `0` | no |
| number_of_computed_egress_with_source_security_group_id | Number of computed egress rules to create where 'source_security_group_id' is used | string | `0` | no |
| number_of_computed_ingress_cidr_blocks | Number of IPv4 CIDR ranges to use on all computed ingress rules | string | `0` | no |
| number_of_computed_ingress_ipv6_cidr_blocks | Number of IPv6 CIDR ranges to use on all computed ingress rules | string | `0` | no |
| number_of_computed_ingress_prefix_list_ids | Number of prefix list IDs (for allowing access to VPC endpoints) to use on all computed ingress rules | string | `0` | no |
| number_of_computed_ingress_rules | Number of computed ingress rules to create by name | string | `0` | no |
| number_of_computed_ingress_with_cidr_blocks | Number of computed ingress rules to create where 'cidr_blocks' is used | string | `0` | no |
| number_of_computed_ingress_with_ipv6_cidr_blocks | Number of computed ingress rules to create where 'ipv6_cidr_blocks' is used | string | `0` | no |
| number_of_computed_ingress_with_self | Number of computed ingress rules to create where 'self' is defined | string | `0` | no |
| number_of_computed_ingress_with_source_security_group_id | Number of computed ingress rules to create where 'source_security_group_id' is used | string | `0` | no |
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
