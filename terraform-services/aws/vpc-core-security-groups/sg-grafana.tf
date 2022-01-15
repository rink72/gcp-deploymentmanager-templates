resource "aws_security_group" "sg_grafana" {
  name        = local.grafana_sgname
  description = "Allow External Management"
  vpc_id      = data.aws_vpc.core_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["202.150.125.157/32", "219.89.202.60/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.grafana_sgname
  }
}
