# web - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "web_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/web"

  # omitted...
}
```

All automatic values **web module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/web/auto_values.tf).
