variable region {
  description = "Target AWS region"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC to create."
}

variable "vpc_cidr" {
  description = "The CIDR to use for the VPC."
}

variable "vpc_azs" {
  type = list(string)
}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "vpc_public_subnets" {
  type = list(string)
}

variable domain_name {
  description = "The name of the domain that will be deployed in the VPC"
  type        = string
  default     = ""
}

variable dns_servers {
  description = "The DNS servers to configure for the VPC"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}
