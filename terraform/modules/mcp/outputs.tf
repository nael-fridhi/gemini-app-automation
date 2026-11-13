output "repository_url" {
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.mcp_repo.repository_id}"
  description = "The Artifact Registry Docker repository URL"
}

output "service_url" {
  value       = google_cloud_run_v2_service.mcp_service.uri
  description = "The URL of the deployed Cloud Run MCP service"
}

output "sse_endpoint" {
  value       = "${google_cloud_run_v2_service.mcp_service.uri}/sse"
  description = "The Server-Sent Events (SSE) connection endpoint of the MCP server"
}
