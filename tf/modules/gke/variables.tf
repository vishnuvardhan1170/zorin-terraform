variable "project_id" { type = string }
variable "cluster_name" { type = string }
variable "region" { type = string }
variable "network" { type = string }
variable "subnetwork" { type = string }
variable "node_count" { type = number }
variable "machine_type" { type = string }
variable "environment" { type = string }
variable "node_service_account" { type = string }
variable "ip_range_pods" {
  description = "Name of the secondary IP range for pods"
  type        = string
}
variable "ip_range_services" {
  description = "Name of the secondary IP range for services"
  type        = string
}   