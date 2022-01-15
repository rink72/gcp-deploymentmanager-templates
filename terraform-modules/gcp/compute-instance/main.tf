locals {
  name = join("-", [substr(var.environment, 0, 1), var.app_code])

  labels = {
    Terraform   = "true",
    Owner       = var.owner,
    Environment = var.environment
    Workload    = var.workload
    App-Code    = var.app_code
  }
}

resource "google_compute_instance" "gci" {
  count = var.machine_count

  name         = format("%s%02d", local.name, count.index + 1)
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = local.labels

  metadata_startup_script = var.metadata_startup_script

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
