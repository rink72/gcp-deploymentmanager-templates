# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Locals for entire account
locals {
  default_yaml_path = find_in_parent_folders("empty.yml")
  project_vars      = yamldecode(file("${find_in_parent_folders("project-vars.yml")}"))

}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "google" {
  project = "${local.project_vars.project}"
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an GCS bucket
remote_state {
  backend = "gcs"

  config = {
    bucket = local.project_vars.state_bucket_name
    prefix = "${path_relative_to_include()}"
  }
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge()
