# ipsec-500 - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "ipsec_500_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ipsec-500"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **ipsec-500 module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/ipsec-500/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
