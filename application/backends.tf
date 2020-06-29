terraform {
  backend "gcs" {
    # Generate a bucket with ./remote-state/init.tf
    bucket  = "f468f397-fe72-6238-427b-eea8fe609f2c"
    prefix  = "demo"
    credentials = "key.json"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "f4bec2fe-f6cf-c734-71cd-1ecf5d13f94e"
    prefix = "demo"
    credentials = "key.json"
  }
}