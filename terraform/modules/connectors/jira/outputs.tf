output "connector_id" {
  value       = google_discovery_engine_data_connector.jira-connector.id
  description = "The fully qualified ID of the Jira Data Connector"
}

output "jira_client_id_secret_id" {
  value       = google_secret_manager_secret.jira_client_id.id
  description = "The Secret Manager Resource Name for the Jira Client ID"
}

output "jira_client_secret_secret_id" {
  value       = google_secret_manager_secret.jira_client_secret.id
  description = "The Secret Manager Resource Name for the Jira Client Secret"
}

output "jira_instance_id_secret_id" {
  value       = google_secret_manager_secret.jira_instance_id.id
  description = "The Secret Manager Resource Name for the Jira Instance/Workspace ID"
}

output "jira_data_store_id" {
  value       = element(split("/", google_discovery_engine_data_connector.jira-connector.entities[0].data_store), 7)
  description = "The auto-generated Data Store ID for the Jira connector"
}
