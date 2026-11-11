terraform {
  required_version = ">= 1.7.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.15"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region

  default_tags {
    tags = {
      project     = "zorin"
      environment = var.environment
      managed_by  = "Terraform"
    }
  }
}   