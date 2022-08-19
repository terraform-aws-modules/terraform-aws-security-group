# oracle-db - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "oracle_db_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/oracle-db"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **oracle-db module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/oracle-db/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
