provider "google" {
  credentials = file(local.credentials)
  project = local.proj_id
  region  = "us-east1"
  zone    = "us-east1-b"
}
