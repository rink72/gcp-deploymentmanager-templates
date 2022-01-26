module "ec2_instance" {
  source = "../../terraform-modules/aws-ec2-instance"

  environment = var.environment
  location    = var.location
  app_code    = var.app_code
  workload    = var.workload
  owner       = var.owner

  instance_count = var.instance_count

  iam_instance_profile = var.iam_instance_profile

  ami_search_filter      = var.ami_search_filter
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = data.aws_security_group.security_group.*.id

  subnet_ids  = data.aws_subnet.subnet.*.id
  private_ips = var.private_ips

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      encrypted   = true
    }
  ]
}
