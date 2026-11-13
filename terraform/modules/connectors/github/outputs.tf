output "connector_id" {
  value       = google_discovery_engine_data_connector.github-connector.id
  description = "The fully qualified ID of the GitHub Data Connector"
}

output "github_client_id_secret_id" {
  value       = google_secret_manager_secret.github_client_id.id
  description = "The Secret Manager Resource Name for the GitHub Client ID"
}

output "github_client_secret_secret_id" {
  value       = google_secret_manager_secret.github_client_secret.id
  description = "The Secret Manager Resource Name for the GitHub Client Secret"
}

output "github_refresh_token_secret_id" {
  value       = google_secret_manager_secret.github_refresh_token.id
  description = "The Secret Manager Resource Name for the GitHub Refresh Token"
}

output "github_data_store_id" {
  value       = element(split("/", google_discovery_engine_data_connector.github-connector.entities[0].data_store), 7)
  description = "The auto-generated Data Store ID for the GitHub connector"
}
