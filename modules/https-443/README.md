# https-443 - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "https_443_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  # omitted...
}
```

All automatic values **https-443 module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/https-443/auto_values.tf).
