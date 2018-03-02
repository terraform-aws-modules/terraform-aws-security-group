# zipkin - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "zipkin_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/zipkin"

  # omitted...
}
```

All automatic values **zipkin module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/zipkin/auto_values.tf).
