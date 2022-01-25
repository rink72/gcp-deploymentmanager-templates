locals {
  labels = {
    terraform   = "true",
    owner       = var.owner,
    environment = var.environment
    appcode     = var.app_code
  }
}

resource "google_compute_instance" "gci" {
  count = var.machine_count

  name         = format("%s%02d", var.app_code, count.index + 1)
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  labels = local.labels

  metadata_startup_script = var.metadata_startup_script
}
