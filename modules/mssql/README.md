# mssql - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "mssql_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/mssql"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **mssql module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/mssql/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
