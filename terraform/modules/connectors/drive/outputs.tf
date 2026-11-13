output "connector_id" {
  value       = google_discovery_engine_data_connector.drive-connector.id
  description = "The fully qualified ID of the Google Drive Data Connector"
}

output "drive_client_id_secret_id" {
  value       = google_secret_manager_secret.drive_client_id.id
  description = "The Secret Manager Resource Name for the Google Drive Client ID"
}

output "drive_client_secret_secret_id" {
  value       = google_secret_manager_secret.drive_client_secret.id
  description = "The Secret Manager Resource Name for the Google Drive Client Secret"
}

output "drive_data_store_id" {
  value       = element(split("/", google_discovery_engine_data_connector.drive-connector.entities[0].data_store), 7)
  description = "The auto-generated Data Store ID for the Google Drive connector"
}
