# We define most of the variables used in the rest of the deployment here.
# This describes the security group, name, subnets and tags
locals {
  private_vpc_subnet1                = "${var.private_vpc_name}-private-ap-southeast-2a"
  private_vpc_subnet2                = "${var.private_vpc_name}-private-ap-southeast-2b"
  private_vpc_sgname                 = "${var.private_vpc_name}-route53-sg"
  private_vpc_outbound_resolver_name = "${var.private_vpc_name}-outbound"

  tags = {
    Terraform   = "true",
    Cloud       = "aws",
    Owner       = var.owner,
    Environment = var.environment
  }
}
