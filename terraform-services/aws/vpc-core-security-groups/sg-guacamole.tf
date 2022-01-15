resource "aws_security_group" "guacamole_sg" {

  name        = local.guacamole_sgname
  description = "Guacamole servers"
  vpc_id      = data.aws_vpc.core_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.combined_ranges
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = local.guacamole_sgname
  }
}
