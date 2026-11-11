variable "project_id" { type = string }
variable "cluster_name" { type = string }
variable "cluster_endpoint" { type = string }
variable "cluster_ca_data" { type = string }
variable "region" { type = string }
variable "admin_password" {
  type      = string
  sensitive = true
}   