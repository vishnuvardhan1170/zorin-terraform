output "cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "cluster_name" {
  value = module.gke.cluster_name
}

output "artifact_registry_url" {
  value = module.artifact-registry.repository_url
}   