module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = false
}

resource "aws_vpc_dhcp_options" "dhcp_option_set" {
  domain_name         = var.domain_name
  domain_name_servers = var.dns_servers


  tags = {
    Name = var.domain_name
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_option_assign" {
  vpc_id          = module.vpc.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_option_set.id
}
