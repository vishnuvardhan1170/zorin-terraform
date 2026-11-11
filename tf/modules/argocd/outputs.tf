output "release_name" {
  value = helm_release.argocd.name
}

output "rollouts_release_name" {
  value = helm_release.argo_rollouts.name
}   