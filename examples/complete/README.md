# Complete Security Group example

Configuration in this directory creates set of Security Group and Security Group Rules resources in various combinations.

Data sources are used to discover existing VPC resources (VPC and default security group).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_consul"></a> [consul](#module\_consul) | ../../modules/consul | n/a |
| <a name="module_disabled_security_group"></a> [disabled\_security\_group](#module\_disabled\_security\_group) | ../../ | n/a |
| <a name="module_disabled_submodule"></a> [disabled\_submodule](#module\_disabled\_submodule) | ../../modules/http-80 | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | ../../modules/postgresql | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_vpc_secondary"></a> [vpc\_secondary](#module\_vpc\_secondary) | terraform-aws-modules/vpc/aws | ~> 6.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ec2_managed_prefix_list.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_security_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_consul_security_group_arn"></a> [consul\_security\_group\_arn](#output\_consul\_security\_group\_arn) | The ARN of the consul security group |
| <a name="output_consul_security_group_id"></a> [consul\_security\_group\_id](#output\_consul\_security\_group\_id) | The ID of the consul security group |
| <a name="output_consul_security_group_name"></a> [consul\_security\_group\_name](#output\_consul\_security\_group\_name) | The name of the consul security group |
| <a name="output_consul_security_group_owner_id"></a> [consul\_security\_group\_owner\_id](#output\_consul\_security\_group\_owner\_id) | The owner ID of the consul security group |
| <a name="output_consul_security_group_vpc_id"></a> [consul\_security\_group\_vpc\_id](#output\_consul\_security\_group\_vpc\_id) | The VPC ID of the consul security group |
| <a name="output_postgresql_security_group_arn"></a> [postgresql\_security\_group\_arn](#output\_postgresql\_security\_group\_arn) | The ARN of the postgresql security group |
| <a name="output_postgresql_security_group_id"></a> [postgresql\_security\_group\_id](#output\_postgresql\_security\_group\_id) | The ID of the postgresql security group |
| <a name="output_postgresql_security_group_name"></a> [postgresql\_security\_group\_name](#output\_postgresql\_security\_group\_name) | The name of the postgresql security group |
| <a name="output_postgresql_security_group_owner_id"></a> [postgresql\_security\_group\_owner\_id](#output\_postgresql\_security\_group\_owner\_id) | The owner ID of the postgresql security group |
| <a name="output_postgresql_security_group_vpc_id"></a> [postgresql\_security\_group\_vpc\_id](#output\_postgresql\_security\_group\_vpc\_id) | The VPC ID of the postgresql security group |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID of the security group |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID of the security group |
<!-- END_TF_DOCS -->
