variable region {
  description = "Target AWS region"
  type        = string
}

variable security_group_names {
  description = "List of security group names. At least one must be provided."
  type        = list(string)
}

variable kibana_alb_security_group_names {
  description = "List of security group names. At least one must be provided."
  type        = list(string)
}

variable "vpc_name" {
  description = "The VPC to deploy in to."
}

variable subnet_names {
  description = "The subnets to deploy the EC2 instances in to. There needs to be one specified per instance."
  type        = list(string)
}

variable lb_subnet_names {
  description = "The subnets to use for deploying the NLB for Elasticsearch"
  type        = list(string)
}

variable kibana_alb_subnet_names {
  description = "The subnets to use for deploying the ALB for Kibana"
  type        = list(string)
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

variable owner {
  description = "Owner of deployment. Human readable for tagging."
  type        = string
}

variable r53_zonename {
  description = "The name of the Route53 zone to create DNS records in."
  type        = string
}

