module "vpc" {
  source = "./modules/vpc"

  name         = "${var.cluster_name}-vpc"
  cidr         = var.vpc_cidr
  region       = var.gcp_region
  cluster_name = var.cluster_name
  environment  = var.environment
}

module "gke" {
  source = "./modules/gke"

  project_id           = var.gcp_project
  cluster_name         = var.cluster_name
  region               = var.gcp_region
  network              = module.vpc.network_name
  subnetwork           = module.vpc.subnetwork_name
  node_count           = var.node_count
  machine_type         = var.node_machine_type
  environment          = var.environment
  node_service_account = google_service_account.node.email
  ip_range_pods        = "${var.cluster_name}-pods"
  ip_range_services    = "${var.cluster_name}-services"
}

module "artifact-registry" {
  source = "./modules/artifact-registry"

  project_id    = var.gcp_project
  location      = var.gcp_region
  repository_id = "zorin"
}
