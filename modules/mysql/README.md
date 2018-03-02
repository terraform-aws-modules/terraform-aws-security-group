# mysql - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "mysql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/mysql"

  # omitted...
}
```

All automatic values **mysql module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/mysql/auto_values.tf).
