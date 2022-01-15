variable "private_vpc_name" {
  description = "The name of the private VPC for the account."
  type        = string
}

variable "internal_dns_servers" {
  description = "The IP addresses of our internal DNS servers (AD Servers) used by outbound DNS to send queries."
  type        = list(any)
}

variable "internal_domain_list" {
  description = "The list of domains that should be forwarded to internal DNS for resolution. ie. jsds1.live"
  type        = list(any)
}

variable "region" {
  description = "Target AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name for tag and naming of instance."
  type        = string
}

variable "owner" {
  description = "Owner of deployment. Human readable for tagging."
  type        = string
}
