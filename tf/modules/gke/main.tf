module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 47.0"

  project_id   = var.project_id
  name         = var.cluster_name
  region       = var.region
  network      = var.network
  subnetwork   = var.subnetwork

  enable_workload_identity = true
  enable_istio             = false
  enable_autopilot         = false

  release_channel = "REGULAR"

  default_node_pool = {
    node_count   = var.node_count
    machine_type = var.machine_type
    disk_size_gb = 50
    auto_repair  = true
    auto_upgrade = true
  }

  tags = {
    environment = var.environment
  }
}   