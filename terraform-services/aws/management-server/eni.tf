resource "aws_eip" "mgmt_eip" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2_instance.id[0]
  allocation_id = aws_eip.mgmt_eip.id
}
