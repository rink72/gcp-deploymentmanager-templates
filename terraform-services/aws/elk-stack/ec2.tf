module "elk_instance" {
  source = "../../terraform-modules/aws-ec2-instance"

  environment = var.environment
  location    = var.location
  app_code    = "elk"
  workload    = "ELK Stack"
  owner       = var.owner

  instance_count = 1

  iam_instance_profile = "instance-profile-general"

  ami_search_filter      = "samexp-server-2019-full-*"
  instance_type          = "t3.large"
  vpc_security_group_ids = data.aws_security_group.security_group.*.id

  subnet_ids = data.aws_subnet.subnet.*.id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 100
      encrypted   = true
    }
  ]
}
