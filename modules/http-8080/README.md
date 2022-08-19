# http-8080 - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "http_8080_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-8080"
  version = "~> 4.0"

  # omitted...
}
```

All automatic values **http-8080 module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/http-8080/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
