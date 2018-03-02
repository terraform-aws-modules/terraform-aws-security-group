# postgresql - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"

  # omitted...
}
```

All automatic values **postgresql module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/postgresql/auto_values.tf).
