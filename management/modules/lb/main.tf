resource "google_compute_instance_group" "servers" {
  name        = "${var.name}-servers"
  description = "A group of ${var.name} servers"

  instances = var.instances

  named_port {
    name = "https"
    port = "80"
  }

  zone = var.zone
}

resource "google_compute_backend_service" "service" {
  name      = "${var.name}-service"
  port_name = "https"
  protocol  = "HTTPS"

  backend {
    group = google_compute_instance_group.servers.id
  }

  health_checks = [
    google_compute_https_health_check.health.id,
  ]
}

resource "google_compute_https_health_check" "health" {
  name         = "${var.name}-health"
  request_path = "/health_check"
}