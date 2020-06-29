# Running this multiple times will crush the previous bucket and anything written to it
# Preserve the state by using a non-random name for the bucket

provider "google" {
  credentials = file("../key.json")
  project = "application-service-cfdemo"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_storage_bucket" "terraform-state" {
  name          = uuid()
  force_destroy = true

  bucket_policy_only = true

  versioning {
    enabled = true
  }
}

# Make a locals tf for the backend name
resource "local_file" "bucket-name-file" {
  content = google_storage_bucket.terraform-state.name
  filename = "bucket_backend.txt"
}