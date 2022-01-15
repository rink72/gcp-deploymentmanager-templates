variable region {
  description = "Target AWS region"
  type        = string
}

variable security_group_names {
  description = "List of security group names. At least one must be provided."
  type        = list(string)
}

variable "vpc_name" {
  description = "The VPC to deploy in to."
}

variable instance_type {
  description = "The EC2 instance type for the sensor."
  type        = string
}

variable subnet_names {
  description = "The subnets to deploy the instances in to. There needs to be one specified per instance."
  type        = list(string)
}

variable location {
  description = "Location name for tag and naming of instance."
  type        = string
  default     = "syd"
}

variable environment {
  description = "The environment the service is being deployed in."
  type        = string
}



