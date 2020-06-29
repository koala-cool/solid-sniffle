resource "google_compute_subnetwork" "subnet-east1" {
  name          = "sub${var.index + 1}"
  ip_cidr_range = cidrsubnet(var.base_cidr, 8, var.index)
  region        = "us-east1"
  network       = var.vpc_network_id
  private_ip_google_access = var.public
}

resource "google_compute_subnetwork" "subnet-east4" {
  name          = "sub${var.index + 2}"
  ip_cidr_range = cidrsubnet(var.base_cidr, 8, var.index + 1)
  region        = "us-east4"
  network       = var.vpc_network_id
  private_ip_google_access = var.public
}