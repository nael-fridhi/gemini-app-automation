# Artifact Registry repository to host MCP Docker images
resource "google_artifact_registry_repository" "mcp_repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker repository for hosting Model Context Protocol (MCP) server container images"
  format        = "DOCKER"
  project       = var.project_id
}

# Cloud Run Service for running the MCP server over SSE transport
resource "google_cloud_run_v2_service" "mcp_service" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    containers {
      image = var.image_url
      ports {
        container_port = 8080
      }
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].containers[0].image # Allow deployment pipelines to push new images without TF rolling back to bootstrap placeholder
    ]
  }
}

# Grant public (unauthenticated) access to the Cloud Run service invoker
resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  project  = var.project_id
  location = google_cloud_run_v2_service.mcp_service.location
  name     = google_cloud_run_v2_service.mcp_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
