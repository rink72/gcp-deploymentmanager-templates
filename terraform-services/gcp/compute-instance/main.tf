module "compute_instance" {
  source = "../../../terraform-modules/gcp/compute-instance"

  environment = var.environment
  zone        = var.zone
  app_code    = var.app_code
  owner       = var.owner

  machine_count = var.machine_count
  machine_type  = var.machine_type
  image         = var.image

  metadata_startup_script = var.metadata_startup_script

  labels = var.labels
}
