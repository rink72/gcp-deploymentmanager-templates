variable "environment" {
  description = "Environment name for label and naming of instance."
  type        = string
}

variable "zone" {
  description = "Zone where instance will be deployed."
  type        = string
}

variable "image" {
  description = "Image to use as base for instance."
  type        = string
}

variable "app_code" {
  description = "Server app-code for label and naming of instance."
  type        = string
}

variable "owner" {
  description = "Owner of deployment. Human readable for labelging."
  type        = string
}

variable "machine_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "The type of instance to start"
  type        = string
}

variable "metadata_startup_script" {
  description = "Startup script to run on machine."
  type        = string
  default     = null
}

variable "labels" {
  description = "A mapping of labels to assign to the resource"
  type        = map(string)
  default     = {}
}
