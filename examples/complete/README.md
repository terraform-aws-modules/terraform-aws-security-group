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

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| complete_sg | ../../ |  |
| fixed_name_sg | ../../ |  |
| ipv4_ipv6_example | ../../ |  |
| main_sg | ../../ |  |
| vpc | terraform-aws-modules/vpc/aws |  |

## Resources

| Name |
|------|
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_security\_group\_description | The description of the security group |
| this\_security\_group\_id | The ID of the security group |
| this\_security\_group\_name | The name of the security group |
| this\_security\_group\_owner\_id | The owner ID |
| this\_security\_group\_vpc\_id | The VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
