# Get the latest version of our AMI. Requires that our packer build has been run.

data "aws_ami" "ami_data" {
  # Look in current account or shared services account
  owners      = ["self", "119760484642"]
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_search_filter]
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

