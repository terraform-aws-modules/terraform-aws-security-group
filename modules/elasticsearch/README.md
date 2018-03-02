# elasticsearch - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "elasticsearch_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/elasticsearch"

  # omitted...
}
```

All automatic values **elasticsearch module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/elasticsearch/auto_values.tf).
