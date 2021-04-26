# HTTP Security Group example

Configuration in this directory creates set of Security Group and Security Group Rules resources in various combination.

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
| <a name="module_http_mysql_1_sg"></a> [http\_mysql\_1\_sg](#module\_http\_mysql\_1\_sg) | ../../modules/http-80 |  |
| <a name="module_http_mysql_2_sg"></a> [http\_mysql\_2\_sg](#module\_http\_mysql\_2\_sg) | ../../modules/http-80 |  |
| <a name="module_http_sg"></a> [http\_sg](#module\_http\_sg) | ../../modules/http-80 |  |
| <a name="module_http_with_egress_minimal_sg"></a> [http\_with\_egress\_minimal\_sg](#module\_http\_with\_egress\_minimal\_sg) | ../../modules/http-80 |  |
| <a name="module_http_with_egress_sg"></a> [http\_with\_egress\_sg](#module\_http\_with\_egress\_sg) | ../../modules/http-80 |  |

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
