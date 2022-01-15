resource "aws_security_group" "es_sg" {

  name        = local.es_sgname
  description = "Elasticsearch servers"
  vpc_id      = data.aws_vpc.core_vpc.id


  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
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
    Name = local.es_sgname
  }
}
