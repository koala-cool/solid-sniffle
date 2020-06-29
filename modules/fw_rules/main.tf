resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags = ["allow-ssh"]
}