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
    value = "ClusterIP"
  }
  set {
    name  = "global.domain"
    value = var.ingress_host
  }
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }
  set {
    name  = "server.ingress.hostname"
    value = var.ingress_host
  }
  set {
    name  = "server.ingress.ingressClassName"
    value = "alb"
  }
  set {
    name  = "configs.params.server.insecure"
    value = "true"
  }
}   