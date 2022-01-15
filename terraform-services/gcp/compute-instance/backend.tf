terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "gcs" {}
  required_version = ">= 0.12"
}
