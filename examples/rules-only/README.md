# Create rules only

Configuration in this directory creates two security groups using native Terraform resources, and then uses the module to add rules.

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

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rules_one"></a> [rules\_one](#module\_rules\_one) | ../../ |  |
| <a name="module_rules_two"></a> [rules\_two](#module\_rules\_two) | ../../ |  |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.service_one](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.service_two](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_one_security_group_id"></a> [service\_one\_security\_group\_id](#output\_service\_one\_security\_group\_id) | The ID of the security group for service one |
| <a name="output_service_two_security_group_id"></a> [service\_two\_security\_group\_id](#output\_service\_two\_security\_group\_id) | The ID of the security group for service two |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
