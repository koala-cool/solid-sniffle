output "allow_ssh" {
  value = google_compute_firewall.allow_ssh.target_tags
}