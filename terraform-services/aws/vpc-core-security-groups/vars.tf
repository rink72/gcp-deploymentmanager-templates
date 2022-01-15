variable "vpc_name" {
  description = "The name of the VPC to create the security group in."
}

variable region {
  description = "Target AWS region"
  type        = string
}

# We're defaulting to everything currently. It could come from anywhere in North America.
variable "ado_ranges" {
  description = "The Azure DevOps IP ranges for hosted agents."
  default     = ["0.0.0.0/0"]
}

variable "custom_ranges" {
  # Note this is coming from terragrunt so comes as a json string. The deployment uses jsondecode to convert this to an array.
  description = "Any extra IP ranges that should be added as external management sources."
  default     = ""
}
