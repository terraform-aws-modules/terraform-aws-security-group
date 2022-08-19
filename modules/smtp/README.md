# smtp - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "smtp_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/smtp"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **smtp module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/smtp/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
