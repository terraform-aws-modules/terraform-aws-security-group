# rdp - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "rdp_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/rdp"
  version = "~> 3.0"

  # omitted...
}
```

All automatic values **rdp module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/rdp/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
