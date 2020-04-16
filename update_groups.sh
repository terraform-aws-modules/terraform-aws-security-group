#!/usr/bin/env bash

# This script generates each public module (eg, "http-80", "ssh") and specify rules required for each group.
# This script should be run after rules.tf is changed to refresh all related modules.
# outputs.tf and variables.tf for all group modules are the same for all

set -e

# Change location to the directory where this script it located
cd "$(dirname "${BASH_SOURCE[0]}")"

check_dependencies() {
  if [[ ! $(command -v sed) ]]; then
    echo "ERROR: The binary 'sed' is required by this script but is not installed or in the system's PATH."
    echo "Check documentation: https://www.gnu.org/software/sed/"
    exit 1
  fi

  if [[ ! $(command -v json2hcl) ]]; then
    echo "ERROR: The binary 'json2hcl' is required by this script but is not installed or in the system's PATH."
    echo "Check documentation: https://github.com/kvz/json2hcl"
    exit 1
  fi

  if [[ ! $(command -v jq) ]]; then
    echo "ERROR: The binary 'jq' is required by this script but is not installed or in the system's PATH."
    echo "Check documentation: https://github.com/stedolan/jq"
    exit 1
  fi
}

auto_groups_data() {
  # Removing line with "type" because it json2hcl works with HCL1 only (ref https://github.com/kvz/json2hcl/issues/12)
  sed '/type/ d' rules.tf | json2hcl -reverse | jq -r '..|.auto_groups?|values|.[0]|.default|.[0]'
}

auto_groups_keys() {
  local data=$1

  echo "$data" | jq -r ".|keys|@sh" | tr -d "'"
}

get_auto_value() {
  local data=$1
  local group=$2
  local var=$3

  echo "$data" | jq -rc '.[$group][0][$var]' --arg group "$group" --arg var "$var"
}

set_list_if_null() {
  if [[ "null" == "$1" ]]; then
    echo "[]"
  else
    echo "$1"
  fi
}

set_zero_if_null() {
  if [[ "null" == "$1" ]]; then
    echo 0
  else
    echo "$1"
  fi
}

main() {
  check_dependencies

  readonly local auto_groups_data="$(auto_groups_data)"

  if [[ -z "$(auto_groups_data)" ]]; then
    echo "There are no modules to update. Check values of auto_groups inside rules.tf"
    exit 0
  fi

  readonly local auto_groups_keys=($(auto_groups_keys "$auto_groups_data"))

  local ingress_rules=""
  local ingress_with_self=""
  local egress_rules=""
  local egress_with_self=""
  local list_of_modules=""

  for group in "${auto_groups_keys[@]}"; do

    echo "Making group: $group"

    mkdir -p "modules/$group"
    cp modules/_templates/{main,outputs,variables,versions}.tf "modules/$group"

    # Get group values
    ingress_rules=$(get_auto_value "$auto_groups_data" "$group" "ingress_rules")
    ingress_with_self=$(get_auto_value "$auto_groups_data" "$group" "ingress_with_self")
    egress_rules=$(get_auto_value "$auto_groups_data" "$group" "egress_rules")
    egress_with_self=$(get_auto_value "$auto_groups_data" "$group" "egress_with_self")

    # Computed values
    computed_ingress_rules=$(get_auto_value "$auto_groups_data" "$group" "computed_ingress_rules")
    computed_ingress_with_self=$(get_auto_value "$auto_groups_data" "$group" "computed_ingress_with_self")
    computed_egress_rules=$(get_auto_value "$auto_groups_data" "$group" "computed_egress_rules")
    computed_egress_with_self=$(get_auto_value "$auto_groups_data" "$group" "computed_egress_with_self")

    # Number of computed values
    number_of_computed_ingress_rules=$(get_auto_value "$auto_groups_data" "$group" "number_of_computed_ingress_rules")
    number_of_computed_ingress_with_self=$(get_auto_value "$auto_groups_data" "$group" "number_of_computed_ingress_with_self")
    number_of_computed_egress_rules=$(get_auto_value "$auto_groups_data" "$group" "number_of_computed_egress_rules")
    number_of_computed_egress_with_self=$(get_auto_value "$auto_groups_data" "$group" "number_of_computed_egress_with_self")

    # Set to empty lists, if no value was specified
    ingress_rules=$(set_list_if_null "$ingress_rules")
    ingress_with_self=$(set_list_if_null "$ingress_with_self")
    egress_rules=$(set_list_if_null "$egress_rules")
    egress_with_self=$(set_list_if_null "$egress_with_self")

    # Set to empty lists, if no computed value was specified
    computed_ingress_rules=$(set_list_if_null "$computed_ingress_rules")
    computed_ingress_with_self=$(set_list_if_null "$computed_ingress_with_self")
    computed_egress_rules=$(set_list_if_null "$computed_egress_rules")
    computed_egress_with_self=$(set_list_if_null "$computed_egress_with_self")

    # Set to zero, if no value was specified
    number_of_computed_ingress_rules=$(set_zero_if_null "$number_of_computed_ingress_rules")
    number_of_computed_ingress_with_self=$(set_zero_if_null "$number_of_computed_ingress_with_self")
    number_of_computed_egress_rules=$(set_zero_if_null "$number_of_computed_egress_rules")
    number_of_computed_egress_with_self=$(set_zero_if_null "$number_of_computed_egress_with_self")

    # ingress_with_self and egress_with_self are stored as simple lists (like this - ["all-all","all-tcp"]),
    # so we make map (like this - [{"rule"="all-all"},{"rule"="all-tcp"}])
    ingress_with_self=$(echo "$ingress_with_self" | jq -rc "[{rule:.[]}]" | tr ':' '=')
    egress_with_self=$(echo "$egress_with_self" | jq -rc "[{rule:.[]}]" | tr ':' '=')

    cat <<EOF > "modules/$group/auto_values.tf"
# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = $ingress_rules
}

variable "auto_ingress_with_self" {
  description = "List of maps defining ingress rules with self to add automatically"
  type        = list(map(string))
  default     = $ingress_with_self
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = $egress_rules
}

variable "auto_egress_with_self" {
  description = "List of maps defining egress rules with self to add automatically"
  type        = list(map(string))
  default     = $egress_with_self
}

# Computed
variable "auto_computed_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = $computed_ingress_rules
}

variable "auto_computed_ingress_with_self" {
  description = "List of maps defining computed ingress rules with self to add automatically"
  type        = list(map(string))
  default     = $computed_ingress_with_self
}

variable "auto_computed_egress_rules" {
  description = "List of computed egress rules to add automatically"
  type        = list(string)
  default     = $computed_egress_rules
}

variable "auto_computed_egress_with_self" {
  description = "List of maps defining computed egress rules with self to add automatically"
  type        = list(map(string))
  default     = $computed_egress_with_self
}

# Number of computed rules
variable "auto_number_of_computed_ingress_rules" {
  description = "Number of computed ingress rules to create by name"
  type        = number
  default     = $number_of_computed_ingress_rules
}

variable "auto_number_of_computed_ingress_with_self" {
  description = "Number of computed ingress rules to create where 'self' is defined"
  type        = number
  default     = $number_of_computed_ingress_with_self
}

variable "auto_number_of_computed_egress_rules" {
  description = "Number of computed egress rules to create by name"
  type        = number
  default     = $number_of_computed_egress_rules
}

variable "auto_number_of_computed_egress_with_self" {
  description = "Number of computed egress rules to create where 'self' is defined"
  type        = number
  default     = $number_of_computed_egress_with_self
}

EOF

    cat <<EOF > "modules/$group/README.md"
# $group - AWS EC2-VPC Security Group Terraform module

## Usage

\`\`\`hcl
module "${group/-/_}_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/${group}"
  version = "~> 3.0"

  # omitted...
}
\`\`\`

All automatic values **${group} module** is using are available [here](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/${group}/auto_values.tf).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
EOF

    list_of_modules=$(echo "$list_of_modules"; echo "* [$group](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/$group)")

    terraform fmt "modules/$group"
  done


  echo "Updating list of security group modules"

  cat <<EOF > modules/README.md
List of Security Groups implemented as Terraform modules
========================================================

$list_of_modules
* [_templates](https://github.com/terraform-aws-modules/terraform-aws-security-group/tree/master/modules/_templates) - Source templates for all other modules. Change carefully, test thoughtfully!

EOF

  echo "Done!"
}

main
