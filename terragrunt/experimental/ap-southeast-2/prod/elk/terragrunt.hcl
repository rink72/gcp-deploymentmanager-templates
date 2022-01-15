# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.

locals {
  account_vars = yamldecode(file("${find_in_parent_folders("account-vars.yml")}"))
  env_vars     = yamldecode(file("${find_in_parent_folders("env.yml")}"))
  vpc_name     = "${local.account_vars.account_name}-${local.env_vars.environment}-core-vpc"
}

terraform {
  source = "${dirname(find_in_parent_folders("root.yml"))}//terraform-services/elk-stack"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  environment                     = local.env_vars.environment
  vpc_name                        = local.vpc_name
  subnet_names                    = ["${local.vpc_name}-public-ap-southeast-2a"]
  lb_subnet_names                 = ["${local.vpc_name}-private-ap-southeast-2a", "${local.vpc_name}-private-ap-southeast-2b"]
  kibana_alb_subnet_names         = ["${local.vpc_name}-public-ap-southeast-2a", "${local.vpc_name}-public-ap-southeast-2b"]
  security_group_names            = ["${local.vpc_name}-member-server-sg", "${local.vpc_name}-ext-management-sg", "${local.vpc_name}-elasticsearch-sg", "${local.vpc_name}-kibana-sg"]
  kibana_alb_security_group_names = ["${local.vpc_name}-kibana-alb-sg"]
  r53_zonename                    = local.account_vars.route53_zonename
  owner                           = "sam"
}
