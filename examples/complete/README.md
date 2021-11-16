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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete_sg"></a> [complete\_sg](#module\_complete\_sg) | ../../ | n/a |
| <a name="module_fixed_name_sg"></a> [fixed\_name\_sg](#module\_fixed\_name\_sg) | ../../ | n/a |
| <a name="module_ipv4_ipv6_example"></a> [ipv4\_ipv6\_example](#module\_ipv4\_ipv6\_example) | ../../ | n/a |
| <a name="module_main_sg"></a> [main\_sg](#module\_main\_sg) | ../../ | n/a |
| <a name="module_only_rules"></a> [only\_rules](#module\_only\_rules) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
