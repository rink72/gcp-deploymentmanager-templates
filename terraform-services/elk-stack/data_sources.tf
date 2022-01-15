
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

data "aws_security_group" "kibana_alb_security_group" {
  count = length(var.kibana_alb_security_group_names)

  filter {
    name   = "tag:Name"
    values = [element(var.kibana_alb_security_group_names, count.index)]
  }
}


data "aws_subnet" "subnet" {
  count = length(var.subnet_names)

  filter {
    name   = "tag:Name"
    values = [element(var.subnet_names, count.index)]
  }
}

data "aws_subnet" "lb_subnets" {
  count = length(var.lb_subnet_names)

  filter {
    name   = "tag:Name"
    values = [element(var.lb_subnet_names, count.index)]
  }
}

data "aws_subnet" "kibana_alb_subnets" {
  count = length(var.kibana_alb_subnet_names)

  filter {
    name   = "tag:Name"
    values = [element(var.kibana_alb_subnet_names, count.index)]
  }
}


# DNS Zone Lookup

data "aws_route53_zone" "r53zone" {
  name = var.r53_zonename
}
