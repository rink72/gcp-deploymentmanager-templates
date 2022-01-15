# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.

locals {
  account_vars = yamldecode(file("${find_in_parent_folders("account-vars.yml")}"))
  env_vars     = yamldecode(file("${find_in_parent_folders("env.yml")}"))
}

terraform {
  source = "${dirname(find_in_parent_folders("root.yml"))}//terraform-services/domain-controllers"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  instance_type        = "t2.medium"
  vpc_name             = "${local.account_vars.account_name}-${local.env_vars.environment}-core-vpc"
  instance_count       = 1
  iam_instance_profile = "instance-profile-general"
  private_ips          = local.env_vars.domain_controller_ips
}
