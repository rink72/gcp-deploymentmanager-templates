# Get the core VPC data to use in deployment
data "aws_vpc" "core_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
