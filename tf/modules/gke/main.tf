module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 47.0"

  project_id = var.project_id
  name       = var.cluster_name
  region     = var.region
  network    = var.network
  subnetwork = var.subnetwork

  identity_namespace = "enabled"

  remove_default_node_pool = true
  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = var.machine_type
      min_count       = tostring(var.node_count)
      max_count       = tostring(var.node_count)
      disk_size_gb    = "50"
      auto_repair     = "true"
      auto_upgrade    = "true"
      service_account = var.node_service_account
    },
  ]

  ip_range_pods     = var.ip_range_pods
  ip_range_services = var.ip_range_services

  cluster_resource_labels = {
    environment = var.environment
  }

  release_channel = "REGULAR"
}   