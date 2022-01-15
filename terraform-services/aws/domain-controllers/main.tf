locals {
}

resource "aws_kms_key" "this" {
}

module "ec2_dcs" {
  source = "../../terraform-modules/aws-ec2-instance"

  environment = var.environment
  location    = var.location
  app_code    = var.app_code
  workload    = "Domain Controller"
  owner       = var.owner

  instance_count = var.instance_count

  ami_id                 = data.aws_ami.winserver2019.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.dc_sg.this_security_group_id, data.aws_security_group.ext-mgt-sg.id]

  subnet_ids           = [data.aws_subnet.subnet.id]
  iam_instance_profile = var.iam_instance_profile

  private_ips = var.private_ips

  associate_public_ip_address = true

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
    }
  ]

  tags = {
    AnsibleGroup = "dc"
  }
}
