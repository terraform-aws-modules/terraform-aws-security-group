# Upgrade from v5.x to v6.x

If you have any questions regarding this upgrade process, please consult the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/examples) directory:
If you find a bug, please open an issue with supporting configuration to reproduce.

## Why the input shape changed

The AWS provider v6 retires `aws_security_group_rule` and the inline `ingress` / `egress` blocks in favor of one resource per rule (`aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule`). On those resources every source attribute is singular: a rule has exactly one of `cidr_ipv4`, `cidr_ipv6`, `prefix_list_id`, or `referenced_security_group_id`. The provider no longer accepts the v5-style plural `cidr_blocks`/`ipv6_cidr_blocks`/`prefix_list_ids` lists on a single rule.

This change rules out v5's "implicit fan-out" patterns where a single module input expanded into N rules (e.g. `ingress_cidr_blocks = ["10.0.0.0/16", "172.16.0.0/12"]` + `ingress_rules = ["postgresql-tcp"]` produced two rules). v6 makes that fan-out explicit, and for the root module it removes preset names entirely:

- The **root module** is now a primitive — it accepts only structured `ingress_rules` / `egress_rules` (`map(object({ ... }))`). Each map entry maps 1:1 to a v6 rule resource. There is no preset list, no source-companion variables.
- The **preset submodules** (`modules/<service>/`) are the sole mechanism for preset convenience. Each submodule wraps the root with one curated rule list and exposes `ingress_cidr_ipv4` / `ingress_cidr_ipv6` / `ingress_prefix_list_id` / `ingress_referenced_security_group_id` as `map(string)` inputs. Each entry produces one rule per preset rule, so a single submodule call still opens its preset to multiple sources without ambiguity.

If you previously mixed preset names with explicit rules in a single root-module call, the v6 path is to either call multiple preset submodules, or write the rules you want directly on the root module.

## List of backwards incompatible changes

- Terraform `v1.5.7` is now minimum supported version
- AWS provider `v6.0.0` is now minimum supported version (the module pins `>= 6.29`)
- The module has been rewritten on top of the AWS provider v6 resources `aws_security_group`, `aws_vpc_security_group_ingress_rule`, `aws_vpc_security_group_egress_rule`, `aws_vpc_security_group_rules_exclusive`, and `aws_vpc_security_group_vpc_association`. The v5 use of `aws_security_group_rule` and inline `ingress` / `egress` blocks has been removed
- Rule inputs are now structured maps. The v5 `ingress_rules` / `egress_rules` lists of named-rule strings, and the `ingress_with_*` / `egress_with_*` / `computed_ingress_with_*` / `computed_egress_with_*` / `number_of_computed_*` families, have been replaced with `ingress_rules` / `egress_rules` of `map(object({ ... }))`
- The root module no longer accepts preset names. Use a preset submodule under `modules/<service>/`, or write structured rules directly via `ingress_rules` / `egress_rules`
- The implicit all-protocols egress rule (v5 default) has been removed. Pass `egress_rules` explicitly to allow outbound traffic
- The implicit self-allow ingress rule (v5 default) has been removed. Add an explicit rule with `referenced_security_group_id = "self"` to restore the behavior; the sentinel is rewritten to the security group's own id at apply time
- `enable_exclusive_rules` is `true` by default. Out-of-band rules added via the AWS console or other Terraform configurations will be reverted on the next apply. Set to `false` to opt out
- `from_port` and `to_port` are typed as `number` (were `string` in v5). When only one of `from_port` / `to_port` is supplied, the other now defaults to it via a symmetric `coalesce`
- The security group no longer receives an implicit `Name` tag set to `var.name`. v5 merged `{ Name = var.name }` into `tags` automatically; v6 passes `var.tags` through unchanged. Set `tags = { Name = "..." }` explicitly if you want to keep the prior behavior

- Submodules:
    - `dax-cluster` has been renamed to `dynamodb-dax`
    - `oracle-db` has been renamed to `oracle`
    - `carbon-relay-ng` has been renamed to `carbon-relay`
    - `kubernetes-api`, `smtp`, `smtps`, `smtp-submission`, `web`, and `zookeeper` have been removed
    - All preset rule keys drop the `-tcp` suffix when the service uses only one protocol (e.g. `postgresql-tcp` -> `postgresql`); both `-tcp` and `-udp` suffixes are kept where the service uses both
    - The four source inputs (`ingress_cidr_ipv4`, `ingress_cidr_ipv6`, `ingress_prefix_list_id`, `ingress_referenced_security_group_id`) are `map(string)` (were singular `string` in earlier v6 drafts and `list(string)` in v5). Each entry produces one ingress rule per preset rule; the four maps may be combined in a single call

## Additional changes

### Modified

- The root module now creates one `aws_vpc_security_group_ingress_rule` / `aws_vpc_security_group_egress_rule` per rule. Rule attachments live on a separate resource and are managed independently of the security group's lifecycle
- Tags can be set per rule via the `tags` field on each rule object. The per-rule `Name` tag defaults to the rule's map key
- `aws_vpc_security_group_rules_exclusive` is created when `enable_exclusive_rules = true` (the default). It enforces that the module owns the full set of rules on the security group
- `aws_vpc_security_group_vpc_association` allows associating the security group with additional VPCs (used by RAM-shared security groups). Provide via `vpc_associations`

### Variable and output changes

1. Removed root-module variables:

    - `ingress_cidr_blocks`
    - `ingress_ipv6_cidr_blocks`
    - `ingress_prefix_list_ids`
    - `ingress_with_cidr_blocks`
    - `ingress_with_ipv6_cidr_blocks`
    - `ingress_with_source_security_group_id`
    - `ingress_with_self`
    - `egress_cidr_blocks`
    - `egress_ipv6_cidr_blocks`
    - `egress_prefix_list_ids`
    - `egress_with_cidr_blocks`
    - `egress_with_ipv6_cidr_blocks`
    - `egress_with_source_security_group_id`
    - `egress_with_self`
    - `computed_ingress_cidr_blocks`
    - `computed_ingress_ipv6_cidr_blocks`
    - `computed_ingress_with_cidr_blocks`
    - `computed_ingress_with_ipv6_cidr_blocks`
    - `computed_ingress_with_source_security_group_id`
    - `computed_ingress_with_self`
    - `computed_egress_cidr_blocks`
    - `computed_egress_ipv6_cidr_blocks`
    - `computed_egress_with_cidr_blocks`
    - `computed_egress_with_ipv6_cidr_blocks`
    - `computed_egress_with_source_security_group_id`
    - `computed_egress_with_self`
    - `number_of_computed_*` family
    - `ingress_cidr_ipv4`, `ingress_cidr_ipv6`, `ingress_prefix_list_id`, `ingress_referenced_security_group_id` (root module — moved to the preset submodules)
    - `egress_cidr_ipv4`, `egress_cidr_ipv6`, `egress_prefix_list_id`, `egress_referenced_security_group_id` (root module)
    - `ingress_presets`, `egress_presets` (preset names are no longer accepted on the root module)
    - `auto_ingress_rules` / `auto_ingress_with_self` (preset submodules)
    - `auto_egress_rules` / `auto_egress_with_self` (preset submodules)

2. Renamed root-module variables:

    - `ingress_rules` (was `list(string)` of preset names) -> `ingress_rules` (`map(object({ ... }))` of structured rules)
    - `egress_rules` (was `list(string)` of preset names) -> `egress_rules` (`map(object({ ... }))` of structured rules)

3. Added root-module variables:

    - `vpc_associations`
    - `enable_exclusive_rules`
    - `region`
    - `timeouts`

4. Submodule source inputs:

    - `ingress_cidr_ipv4` (`map(string)`)
    - `ingress_cidr_ipv6` (`map(string)`)
    - `ingress_prefix_list_id` (`map(string)`)
    - `ingress_referenced_security_group_id` (`map(string)`; use value `"self"` to reference the security group created by the submodule)

5. Renamed outputs:

    - `security_group_id` -> `id`
    - `security_group_arn` -> `arn`
    - `security_group_vpc_id` -> `vpc_id`
    - `security_group_owner_id` -> `owner_id`
    - `security_group_name` -> `name`
    - `security_group_description` has been removed - use `description` from the input
    - `this_security_group_*` aliases have been removed

### Diff of before <> after

#### Root module - explicit rules

```diff
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
-  version = "~> 5.0"
+  version = "~> 6.0"

  name        = "example"
  description = "Example security group"
  vpc_id      = "vpc-12345678"

-  ingress_cidr_blocks = ["10.0.0.0/16"]
-  ingress_rules       = ["https-443-tcp"]
-  ingress_with_self   = [{ rule = "all-all" }]
+  ingress_rules = {
+    https = {
+      from_port   = 443
+      ip_protocol = "tcp"
+      cidr_ipv4   = "10.0.0.0/16"
+    }
+    self-all = {
+      ip_protocol                  = "-1"
+      referenced_security_group_id = "self"
+    }
+  }

-  egress_rules = ["all-all"]
+  egress_rules = {
+    all = {
+      ip_protocol = "-1"
+      cidr_ipv4   = "0.0.0.0/0"
+    }
+  }
}
```

#### Preset submodule

```diff
module "postgresql" {
  source  = "terraform-aws-modules/security-group/aws//modules/postgresql"
-  version = "~> 5.0"
+  version = "~> 6.0"

  name        = "postgresql"
  description = "PostgreSQL access"
  vpc_id      = "vpc-12345678"

-  ingress_cidr_blocks = ["10.0.0.0/16", "172.16.0.0/12"]
+  ingress_cidr_ipv4 = {
+    vpc  = "10.0.0.0/16"
+    peer = "172.16.0.0/12"
+  }
}
```

#### v5 root with preset names -> v6 preset submodule(s)

```diff
-module "security_group" {
-  source  = "terraform-aws-modules/security-group/aws"
-  version = "~> 5.0"
-
-  name        = "example"
-  description = "PostgreSQL + SSH access"
-  vpc_id      = "vpc-12345678"
-
-  ingress_cidr_blocks = ["10.0.0.0/16"]
-  ingress_rules       = ["postgresql-tcp", "ssh-tcp"]
-
-  egress_rules = ["all-all"]
-}
+module "postgresql" {
+  source  = "terraform-aws-modules/security-group/aws//modules/postgresql"
+  version = "~> 6.0"
+
+  name   = "example-postgresql"
+  vpc_id = "vpc-12345678"
+
+  ingress_cidr_ipv4 = {
+    vpc = "10.0.0.0/16"
+  }
+
+  egress_rules = {
+    all = {
+      ip_protocol = "-1"
+      cidr_ipv4   = "0.0.0.0/0"
+    }
+  }
+}
+
+module "ssh" {
+  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
+  version = "~> 6.0"
+
+  name   = "example-ssh"
+  vpc_id = "vpc-12345678"
+
+  ingress_cidr_ipv4 = {
+    vpc = "10.0.0.0/16"
+  }
+
+  egress_rules = {
+    all = {
+      ip_protocol = "-1"
+      cidr_ipv4   = "0.0.0.0/0"
+    }
+  }
+}
```

#### Renamed / removed submodules

```diff
module "dax" {
-  source = "terraform-aws-modules/security-group/aws//modules/dax-cluster"
+  source = "terraform-aws-modules/security-group/aws//modules/dynamodb-dax"
}

module "oracle" {
-  source = "terraform-aws-modules/security-group/aws//modules/oracle-db"
+  source = "terraform-aws-modules/security-group/aws//modules/oracle"
}

module "carbon" {
-  source = "terraform-aws-modules/security-group/aws//modules/carbon-relay-ng"
+  source = "terraform-aws-modules/security-group/aws//modules/carbon-relay"
}
```

For `kubernetes-api`, `smtp`, `smtps`, `smtp-submission`, `web`, and `zookeeper` (removed), define the equivalent rules directly on the root module via `ingress_rules`.
