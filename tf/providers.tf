terraform {
  required_version = ">= 1.7.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region

  default_labels = {
    project     = "zorin"
    environment = var.environment
    managed_by  = "terraform"
  }
}   