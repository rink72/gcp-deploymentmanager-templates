variable region {
  description = "Target AWS region"
  type        = string
}

variable security_group_names {
  description = "List of security group names. At least one must be provided."
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type to deploy"
}

variable "vpc_name" {
  description = "The VPC to deploy in to."
}

variable subnet_names {
  description = "The subnets to deploy the instances in to. There needs to be one specified per instance."
  type        = list(string)
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable ami_search_filter {
  description = "The ami filter to use when searching for AMIs"
  type        = string
  default     = "pwrc-server-2019-core-*"
}

variable "ami_id" {
  description = "ID of AMI to use for the instance. The default will have the ec2 module use the latest core image."
  type        = string
  default     = ""
}

variable environment {
  description = "Environment name for tag and naming of instance."
  type        = string
}

variable location {
  description = "Location name for tag and naming of instance."
  type        = string
  default     = "syd"
}

variable app_code {
  description = "Server app-code for tag and naming of instance."
  type        = string
}

variable workload {
  description = "Server workload. Human readable for tagging."
  type        = string
}

variable owner {
  description = "Owner of deployment. Human readable for tagging."
  type        = string
}

variable iam_instance_profile {
  description = "Instance profile to assign to instance"
  type        = string
  default     = "instance-profile-general"
}

variable "private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}


