terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
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
    host = var.cluster_endpoint
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}