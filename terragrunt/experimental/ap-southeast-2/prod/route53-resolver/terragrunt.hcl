# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.

locals {
  account_vars = yamldecode(file("${find_in_parent_folders("account-vars.yml")}"))
  env_vars     = yamldecode(file("${find_in_parent_folders("env.yml")}"))
  vpc_name     = "${local.account_vars.account_name}-${local.env_vars.environment}-core-vpc"
}

terraform {
  source = "${dirname(find_in_parent_folders("root.yml"))}//terraform-services/route53-resolver"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  owner                = "Sam"
  private_vpc_name     = local.vpc_name
  internal_dns_servers = local.env_vars.domain_controller_ips
  internal_domain_list = ["sam.local"]
  environment          = local.env_vars.environment
}
