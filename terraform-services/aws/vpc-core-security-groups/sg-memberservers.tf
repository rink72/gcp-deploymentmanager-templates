resource "aws_security_group" "member_servers_sg" {

  name        = local.member_sgname
  description = "Domain member servers"
  vpc_id      = data.aws_vpc.core_vpc.id

  # This allows all comms with servers this security group is attached too (should only be domain controllers)
  # ingress_with_self = [{
  #   rule = "all-all"
  # }]

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = local.combined_ranges
  }

  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = local.combined_ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.member_sgname
  }
}
