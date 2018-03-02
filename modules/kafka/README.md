# kafka - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "kafka_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/kafka"

  # omitted...
}
```

All automatic values **kafka module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/kafka/auto_values.tf).
