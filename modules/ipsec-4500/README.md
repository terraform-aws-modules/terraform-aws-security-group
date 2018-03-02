# ipsec-4500 - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "ipsec_4500_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ipsec-4500"

  # omitted...
}
```

All automatic values **ipsec-4500 module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/ipsec-4500/auto_values.tf).
