output "network_name" {
  value = google_compute_network.vpc.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.nodes.name
}

output "subnetwork_self_link" {
  value = google_compute_subnetwork.nodes.self_link
}   