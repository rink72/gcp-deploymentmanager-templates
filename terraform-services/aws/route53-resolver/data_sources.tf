# The resolver is deployed in the private VPC. Get the ID of this VPC from the name.
data "aws_vpc" "private_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.private_vpc_name]
  }
}

# This looks up the security group that will be applied to the resolver
data "aws_security_group" "private_vpc_sg" {

  filter {
    name   = "tag:Name"
    values = [local.private_vpc_sgname]
  }
}

# We hard code that the resolver will be deployed in two different subnets. These lookup those ids.
data "aws_subnet" "private_vpc_sn1" {

  filter {
    name   = "tag:Name"
    values = [local.private_vpc_subnet1]
  }
}

data "aws_subnet" "private_vpc_sn2" {

  filter {
    name   = "tag:Name"
    values = [local.private_vpc_subnet2]
  }
}
