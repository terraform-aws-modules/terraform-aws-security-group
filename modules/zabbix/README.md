# zabbix - AWS EC2-VPC Security Group Terraform module

## Usage

```hcl
module "zabbix_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/zabbix"
  version = "~> 6.0"

  # omitted...
}
```

All automatic values **zabbix module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/zabbix/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
