output "metrics_server_helm_metadata" {
  description = "block status of the metrics-server helm release"
  value       = helm_release.metrics_server.metadata
}
