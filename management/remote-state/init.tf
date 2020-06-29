# Running this multiple times will crush the previous bucket and anything written to it
# Preserve the state by using a non-random name for the bucket

provider "google" {
  credentials = file("../key.json")
  project = "management-host-cfdemo"
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

# Give read access to application
resource "google_storage_bucket_iam_binding" "terraform-state-admin" {
  bucket = google_storage_bucket.terraform-state.name
  role = "roles/storage.admin"
  # Owner doesn't provide storage.objects.get and it's required to use as a backend for remote-state
  members = [
    "serviceAccount:management-terraform-cfdemo@management-host-cfdemo.iam.gserviceaccount.com",
  ]
}

# Give read access to application
resource "google_storage_bucket_iam_binding" "terraform-state-reader" {
  bucket = google_storage_bucket.terraform-state.name
  role = "roles/storage.objectViewer"
  # Owner doesn't provide storage.objects.get and it's required to use as a backend for remote-state
  members = [
    "serviceAccount:terraform-cfdemo@application-service-cfdemo.iam.gserviceaccount.com",
  ]
}

# Make a locals tf for the backend name
resource "local_file" "bucket-name-file" {
  content = google_storage_bucket.terraform-state.name
  filename = "bucket_backend.txt"
}