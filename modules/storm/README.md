# storm - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "storm_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/storm"

  # omitted...
}
```

All automatic values **storm module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/storm/auto_values.tf).
