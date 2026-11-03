output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "argocd_ingress_host" {
  value = module.argocd.ingress_host
}   