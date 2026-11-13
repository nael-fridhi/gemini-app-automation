resource "google_discovery_engine_data_store" "workspace_store" {
  provider          = google-beta
  project           = var.project_id
  location          = var.location
  data_store_id     = "${var.app_name}-workspace-ds"
  display_name      = "${var.company_name} Workspace Data Store"
  industry_vertical = "GENERIC"
  content_config    = "CONTENT_REQUIRED"
  solution_types    = ["SOLUTION_TYPE_SEARCH"]

  lifecycle {
    ignore_changes = [
      document_processing_config
    ]
  }
}
