output "cluster_name" {
  value = module.gke.name
}

output "cluster_endpoint" {
  value = module.gke.endpoint
}

output "cluster_ca_cert" {
  value = module.gke.ca_certificate
}

output "gke_cluster_service_account" {
  value = module.gke.service_account
}   