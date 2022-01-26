locals {
  is_t_instance_type = replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? true : false
  # If AMI ID is specified, use that instead of the data source AMI
  ami_id = var.ami_id == "" ? data.aws_ami.ami_data.image_id : var.ami_id

  name = join("", [substr(var.environment, 0, 1), substr(var.location, 0, 3), var.app_code])

  common_tags = {
    Terraform   = "true",
    Cloud       = "aws",
    Owner       = var.owner,
    Environment = var.environment
    Workload    = var.workload
    App-Code    = var.app_code
  }


  tags = {
    Terraform   = "true",
    Cloud       = "aws",
    Owner       = var.owner,
    Environment = var.environment
    Workload    = var.workload
    App-Code    = var.app_code
  }

}


resource "aws_instance" "this" {
  count = var.instance_count

  ami              = local.ami_id
  instance_type    = var.instance_type
  user_data_base64 = var.user_data_base64
  subnet_id = length(var.network_interface) > 0 ? null : element(
    distinct(compact(concat([var.subnet_id], var.subnet_ids))),
    count.index,
  )
  monitoring             = var.monitoring
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address
  private_ip                  = length(var.private_ips) > 0 ? element(var.private_ips, count.index) : var.private_ip

  ebs_optimized = var.ebs_optimized

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }

  source_dest_check       = length(var.network_interface) > 0 ? null : var.source_dest_check
  disable_api_termination = var.disable_api_termination
  placement_group         = var.placement_group
  tenancy                 = var.tenancy

  tags = merge(
    {
      "Name" = format("%s%02d", local.name, count.index + 1)
    },
    var.tags,
    local.common_tags
  )

  volume_tags = merge(
    {
      "Name" = format("%s%02d", local.name, count.index + 1)
    },
    var.volume_tags,
    local.tags
  )

  credit_specification {
    cpu_credits = local.is_t_instance_type ? var.cpu_credits : null
  }

  lifecycle {
    # Ignore changes to the AMI ID. We will update the AMI often but don't want
    # to have instances redeployed based on that.
    ignore_changes = [
      ami
    ]
  }
}
