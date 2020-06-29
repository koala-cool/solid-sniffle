resource "google_compute_disk" "storage" {
  name  = "${var.name}-storage-disk"
  zone  = var.zone
  size  = "20"
  physical_block_size_bytes = 4096
}

resource "google_compute_instance" "instance" {
  name         = "${var.name}-instance"
  # n2-standard-2 are in high demand and I'm not aloud any
  machine_type = "f1-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "rhel-7-v20200618"
    }
  }

  attached_disk {
    source = google_compute_disk.storage.self_link
  }

  network_interface {
    subnetwork = var.subnet
  }

  metadata_startup_script = var.script
}