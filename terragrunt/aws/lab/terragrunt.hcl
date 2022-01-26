# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Locals for entire account
locals {
  default_yaml_path = find_in_parent_folders("empty.yml")
  account_vars      = yamldecode(file("${find_in_parent_folders("account-vars.yml")}"))

}


# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = local.account_vars.state_bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.account_vars.region
    dynamodb_table = local.account_vars.state_dynamodb_table
  }
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  # Configure Terragrunt to use common vars encoded as yaml to help you keep often-repeated variables (e.g., account ID)
  # DRY. We use yamldecode to merge the maps into the inputs, as opposed to using varfiles due to a restriction in
  # Terraform >=0.12 that all vars must be defined as variable blocks in modules. Terragrunt inputs are not affected by
  # this restriction.
  yamldecode(
    file("${find_in_parent_folders("region.yaml", local.default_yaml_path)}"),
  ),
  yamldecode(
    file("${find_in_parent_folders("env.yaml", local.default_yaml_path)}"),
  ),
  {
    region = local.account_vars.region
  }
)
