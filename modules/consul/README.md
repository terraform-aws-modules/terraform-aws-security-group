# consul - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "consul_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/consul"

  # omitted...
}
```

All automatic values **consul module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/consul/auto_values.tf).
