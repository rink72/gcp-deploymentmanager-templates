
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_security_group" "security_group" {
  count = length(var.security_group_names)

  filter {
    name   = "tag:Name"
    values = [element(var.security_group_names, count.index)]
  }
}


data "aws_subnet" "subnet" {
  count = length(var.subnet_names)

  filter {
    name   = "tag:Name"
    values = [element(var.subnet_names, count.index)]
  }
}
