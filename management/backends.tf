terraform {
  backend "gcs" {
    # Generate a bucket with ./remote-state/init.tf
    bucket  = "f4bec2fe-f6cf-c734-71cd-1ecf5d13f94e"
    prefix  = "demo"
    credentials = "key.json"
  }
}