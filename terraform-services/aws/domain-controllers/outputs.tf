output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = join(",", module.ec2_dcs.private_ip)
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = join(",", module.ec2_dcs.public_ip)
}
