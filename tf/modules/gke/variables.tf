variable "project_id" { type = string }
variable "cluster_name" { type = string }
variable "region" { type = string }
variable "network" { type = string }
variable "subnetwork" { type = string }
variable "node_count" { type = number }
variable "machine_type" { type = string }
variable "environment" { type = string }
variable "node_service_account" {
  description = "GCP service account for GKE nodes (needs artifactregistry.reader)"
  type        = string
}   