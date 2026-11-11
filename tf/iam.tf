data "google_project" "current" {}

# --- Workload Identity Pool for GitHub Actions ---
resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub OIDC"

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.ref"              = "assertion.ref"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_org}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# --- CI Service Account ---
resource "google_service_account" "ci" {
  account_id   = "ci-bot"
  display_name = "CI Bot"
}

resource "google_service_account_iam_member" "ci_wif" {
  service_account_id = google_service_account.ci.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/github-pool/attribute.repository/${var.github_org}/${var.github_repo}"
}

resource "google_project_iam_member" "ci_artifact_registry" {
  project = var.gcp_project
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.ci.email}"
}

# --- Deploy Service Account ---
resource "google_service_account" "deploy" {
  account_id   = "deploy-bot"
  display_name = "Deploy Bot"
}

resource "google_service_account_iam_member" "deploy_wif" {
  service_account_id = google_service_account.deploy.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/github-pool/attribute.repository/${var.github_org}/${var.github_repo}"
}

# --- Terraform Service Account ---
resource "google_service_account" "terraform" {
  account_id   = "tf-bot"
  display_name = "Terraform Bot"
}

resource "google_service_account_iam_member" "terraform_wif" {
  service_account_id = google_service_account.terraform.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/github-pool/attribute.repository/${var.github_org}/${var.github_repo}"
}

resource "google_project_iam_member" "terraform_gke" {
  project = var.gcp_project
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_project_iam_member" "terraform_artifact_registry" {
  project = var.gcp_project
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_project_iam_member" "terraform_compute" {
  project = var.gcp_project
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_project_iam_member" "terraform_storage" {
  project = var.gcp_project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_project_iam_member" "terraform_service_usage" {
  project = var.gcp_project
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

# --- GKE Node Service Account ---
resource "google_service_account" "node" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node SA"
}

resource "google_project_iam_member" "node_artifact_registry" {
  project = var.gcp_project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.node.email}"
}

# --- Outputs ---
output "wif_provider_full_name" {
  value = "projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github.workload_identity_pool_id}/providers/${google_iam_workload_identity_pool_provider.github.workload_identity_pool_provider_id}"
}

output "ci_sa_email" {
  value = google_service_account.ci.email
}

output "deploy_sa_email" {
  value = google_service_account.deploy.email
}

output "terraform_sa_email" {
  value = google_service_account.terraform.email
}

output "node_sa_email" {
  value = google_service_account.node.email
}   