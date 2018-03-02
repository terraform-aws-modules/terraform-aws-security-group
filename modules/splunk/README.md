# splunk - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "splunk_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/splunk"

  # omitted...
}
```

All automatic values **splunk module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/splunk/auto_values.tf).
