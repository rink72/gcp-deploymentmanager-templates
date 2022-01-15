variable "tf_state_bucket" {
}

variable "tfstate_table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
}
