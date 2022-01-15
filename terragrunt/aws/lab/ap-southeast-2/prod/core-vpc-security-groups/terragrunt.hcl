# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.

locals {
  account_vars = yamldecode(file("${find_in_parent_folders("account-vars.yml")}"))
  env_vars     = yamldecode(file("${find_in_parent_folders("env.yml")}"))
}

terraform {
  source = "${dirname(find_in_parent_folders("root.yml"))}//terraform-services/vpc-core-security-groups"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  vpc_name      = "${local.account_vars.account_name}-${local.env_vars.environment}-core-vpc"
  custom_ranges = ["202.150.125.157/32"]
}
