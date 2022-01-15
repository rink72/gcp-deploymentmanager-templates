variable "instance_type" {
  description = "Instance type to deploy"
}

variable "vpc_name" {
  description = "The VPC to deploy in to."
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable iam_instance_profile {
  description = "Instance profile to assign to instance"
  type        = string
  default     = ""
}

variable environment {
  description = "Environment name for tag and naming of instance."
  type        = string
  default     = "lab"
}

variable location {
  description = "Location name for tag and naming of instance."
  type        = string
  default     = "syd"
}

variable app_code {
  description = "Server function for tag and naming of instance."
  default     = "dc"
}

variable owner {
  description = "Server owner for tagging."
  default     = "sam"
}

variable private_ips {
  description = "Private IPs to assign to servers. One per server."
  type        = list
  default     = []
}
