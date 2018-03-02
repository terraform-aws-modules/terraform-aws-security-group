# ldaps - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "ldaps_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ldaps"

  # omitted...
}
```

All automatic values **ldaps module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/ldaps/auto_values.tf).
