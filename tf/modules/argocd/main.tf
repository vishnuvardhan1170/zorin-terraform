resource "helm_release" "argocd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.3.0"
  namespace  = "argocd"
  create_namespace = true

  set {
    name  = "admin.password"
    value = var.admin_password
  }
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "server.insecure"
    value = "true"
  }
}