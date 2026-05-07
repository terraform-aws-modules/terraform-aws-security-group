# Submodule generator

Pure-Terraform generator that produces `modules/<service>/` from `generate/catalog.tf`. Templates emit `terraform fmt`-clean HCL by construction, so `terraform apply` is the only step needed.

## Usage

```sh
terraform init
terraform apply -auto-approve
```

State (`generate/.terraform/`, `generate/terraform.tfstate*`) is gitignored. A lost state file is recovered by re-running `terraform apply`.

## Adding a service

1. Add an entry to `local.catalog` in `generate/catalog.tf`.
2. Run the workflow above.
3. Commit the new `modules/<service>/` directory.

## Removing a service

1. Delete the entry from `local.catalog`.
2. Run the workflow above (deletes the five generated files via state tracking).
3. Manually `rm -rf modules/<service>/` to remove the now-empty directory.
4. Commit the deletion.
