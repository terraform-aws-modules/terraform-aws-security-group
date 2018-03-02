# carbon-relay-ng - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "carbon_relay-ng_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/carbon-relay-ng"

  # omitted...
}
```

All automatic values **carbon-relay-ng module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/carbon-relay-ng/auto_values.tf).
