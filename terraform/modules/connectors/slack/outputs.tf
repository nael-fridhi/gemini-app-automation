output "connector_id" {
  value       = google_discovery_engine_data_connector.slack-connector.id
  description = "The fully qualified ID of the Slack Data Connector"
}

output "slack_client_id_secret_id" {
  value       = google_secret_manager_secret.slack_client_id.id
  description = "The Secret Manager Resource Name for the Slack Client ID"
}

output "slack_client_secret_secret_id" {
  value       = google_secret_manager_secret.slack_client_secret.id
  description = "The Secret Manager Resource Name for the Slack Client Secret"
}

output "slack_data_store_id" {
  value       = element(split("/", google_discovery_engine_data_connector.slack-connector.entities[0].data_store), 7)
  description = "The auto-generated Data Store ID for the Slack connector"
}

