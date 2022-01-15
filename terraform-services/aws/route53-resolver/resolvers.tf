# This is the configuration for the outbound DNS endpoint. Queries in VPCs for our internal domains will make
# requests to our DNS servers from the IP addresses of this endpoint.
resource "aws_route53_resolver_endpoint" "private_vpc_outbound_resolver" {
  name      = local.private_vpc_outbound_resolver_name
  direction = "OUTBOUND"

  security_group_ids = [data.aws_security_group.private_vpc_sg.id]

  ip_address {
    subnet_id = data.aws_subnet.private_vpc_sn1.id
  }

  ip_address {
    subnet_id = data.aws_subnet.private_vpc_sn2.id
  }

  tags = local.tags
}
