# alertmanager - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "alertmanager_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/alertmanager"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **alertmanager module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/alertmanager/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
