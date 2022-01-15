resource "aws_security_group" "ext_kibana_alb" {
  name        = local.kibana_alb_sgname
  description = "Allow external access to Kibana"
  vpc_id      = data.aws_vpc.core_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "202.150.125.157/32",
      "202.50.140.246/32",
      "202.50.140.254/32",
      "202.50.143.120/32",
      "3.104.207.47/32",
      "13.236.30.72/32",
      "13.55.28.84/32",
      "175.45.116.0/24",
      "165.225.114.0/23",
      "124.248.141.0/24"
    ]
  }


  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "202.150.125.157/32",
      "202.50.140.246/32",
      "202.50.140.254/32",
      "202.50.143.120/32",
      "3.104.207.47/32",
      "13.236.30.72/32",
      "13.55.28.84/32",
      "175.45.116.0/24",
      "165.225.114.0/23",
      "124.248.141.0/24"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.kibana_alb_sgname
  }
}

