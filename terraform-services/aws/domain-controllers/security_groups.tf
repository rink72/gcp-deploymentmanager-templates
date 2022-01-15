module "dc_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "dc-sg"
  description = "Security group for domain controllers"
  vpc_id      = data.aws_vpc.core_vpc.id

  # This allows all comms with servers this security group is attached too (should only be domain controllers)
  ingress_with_self = [{
    rule = "all-all"
  }]

  ingress_with_cidr_blocks = [
    {
      from_port   = 88
      to_port     = 88
      protocol    = "tcp"
      description = "Kerberos authentication"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      rule        = "dns-tcp"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      rule        = "dns-udp"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 135
      to_port     = 135
      protocol    = "udp"
      description = "NetBIOS name service"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 135
      to_port     = 135
      protocol    = "tcp"
      description = "NetBIOS name service"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 137
      to_port     = 139
      protocol    = "udp"
      description = "NetBIOS datagram service and service session"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 137
      to_port     = 139
      protocol    = "tcp"
      description = "NetBIOS datagram service and service session"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 389
      to_port     = 389
      protocol    = "tcp"
      description = "LDAP"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 389
      to_port     = 389
      protocol    = "udp"
      description = "LDAP"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      rule        = "ldaps-tcp"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      description = "Microsoft SMB-CIFS over TCP with NetBIOS framing"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 464
      to_port     = 464
      protocol    = "tcp"
      description = "Kerberos password V5"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 749
      to_port     = 749
      protocol    = "tcp"
      description = "Active Directory Kerberos V change and set password RPCSEC-GSS"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 3268
      to_port     = 3269
      protocol    = "tcp"
      description = "Global catalog comms from clients to DCs"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
    {
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      description = "Client ports to the domain controllers"
      cidr_blocks = data.aws_vpc.core_vpc.cidr_block
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
