output "cluster_name" {
  value = module.gke.cluster_name
}

output "cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "cluster_ca_cert" {
  value = module.gke.cluster_ca_cert
}

output "gke_cluster_service_account" {
  value = module.gke.gke_cluster_service_account
}   