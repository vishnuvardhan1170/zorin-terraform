resource "google_artifact_registry_repository" "this" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_id
  description   = "zorin-app container images"
  format        = "DOCKER"
}   