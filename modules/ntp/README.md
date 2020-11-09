# ntp - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "ntp_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ntp"
  version = "~> 3.0"

  # omitted...
}
```

All automatic values **ntp module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/ntp/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
