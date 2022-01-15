locals {
  mgt_sgname  = "${var.vpc_name}-ext-management-sg"
  subnet_name = "${var.vpc_name}-public-ap-southeast-2a"

  final_tags = {
    Env      = var.environment
    Location = var.location
    AppCode  = var.app_code
  }
}
