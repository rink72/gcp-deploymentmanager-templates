# Get the latest version of our AMI. Requires that our packer build has been run.
# https://github.com/rink72/aws-lab/tree/master/packer/server2019-core
# https://github.com/rink72/aws-lab/tree/master/jenkins/build-amis
data "aws_ami" "winserver2019" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["samexp-server-2019-core-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "core_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_security_group" "ext-mgt-sg" {
  filter {
    name   = "tag:Name"
    values = [local.mgt_sgname]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = [local.subnet_name]
  }
}
