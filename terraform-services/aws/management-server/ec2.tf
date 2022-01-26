module "ec2_instance" {
  source = "../../terraform-modules/aws-ec2-instance"

  environment = var.environment
  location    = var.location
  app_code    = local.app_code
  workload    = local.workload
  owner       = local.owner

  instance_count = 1

  iam_instance_profile = "instance-profile-general"

  ami_search_filter = local.ami_search_filter
  instance_type     = var.instance_type

  subnet_ids             = data.aws_subnet.subnet.*.id
  vpc_security_group_ids = data.aws_security_group.security_group.*.id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      encrypted   = true
    }
  ]
}
