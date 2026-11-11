terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.15"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_ca_data)
    token                  = data.google_client_config.default.access_token
  }
}   