resource "aws_security_group" "kibana_sg" {

  name        = local.kibana_sgname
  description = "Kibana servers"
  vpc_id      = data.aws_vpc.core_vpc.id


  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.core_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.kibana_sgname
  }
}
