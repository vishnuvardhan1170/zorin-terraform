terraform {
  backend "gcs" {
    bucket = "zorin-terraform-state"
    prefix = "prod"
  }
}