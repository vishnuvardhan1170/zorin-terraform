variable "gcp_project" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "zorin"
}

variable "vpc_cidr" {
  description = "VPC subnet CIDR block"
  type        = string
  default     = "10.0.1.0/22"
}

variable "node_count" {
  description = "Number of GKE nodes"
  type        = number
  default     = 1
}

variable "node_machine_type" {
  description = "GKE node machine type"
  type        = string
  default     = "e2-medium"
}

variable "github_org" {
  description = "GitHub organization"
  type        = string
  default     = "vishnuvardhan1170"
}

variable "github_repo" {
  description = "GitHub repository"
  type        = string
  default     = "zorin-terraform"
}

variable "argocd_admin_password" {
  description = "ArgoCD admin password"
  type        = string
  sensitive   = true
}

