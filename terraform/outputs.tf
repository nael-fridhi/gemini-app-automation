output "project_id" {
  description = "The Google Cloud Project ID hosting the Gemini Enterprise App."
  value       = var.project_id
}

output "connector_service_account_email" {
  description = "The Service Account email dedicated to Google Workspace ingestion and Discovery Engine API interactions."
  value       = google_service_account.connector_sa.email
}

output "connector_service_account_unique_id" {
  description = "The Service Account OAuth Client / Unique ID required for granting Domain-Wide Delegation in Google Workspace Admin Console."
  value       = google_service_account.connector_sa.unique_id
}

output "workspace_data_store_id" {
  description = "The Discovery Engine Data Store ID holding unstructured Google Workspace enterprise content."
  value       = module.workspace_store.data_store_id
}

output "gemini_chat_app_id" {
  description = "The Discovery Engine Gemini Enterprise App Engine ID."
  value       = module.app.search_engine_id
}

output "google_workspace_dwd_instructions" {
  description = "Step-by-step instructions for configuring Google Workspace Domain-Wide Delegation (DWD)."
  value       = <<EOT

================================================================================
GOOGLE WORKSPACE DOMAIN-WIDE DELEGATION (DWD) CONFIGURATION
================================================================================

To authorize this Gemini Enterprise App to crawl, index, or search your Google Workspace
corpus (Google Drive, Docs, Cloud Search), register the connector Service Account in your
Google Workspace Admin Console:

1. Navigate to: Google Workspace Admin Console (admin.google.com)
2. Go to: Security > Access and data control > API controls > Manage Domain Wide Delegation
3. Click: 'Add new'
4. Client ID: ${google_service_account.connector_sa.unique_id}
5. OAuth Scopes (Copy & Paste this entire comma-separated line):
   https://www.googleapis.com/auth/drive.readonly,https://www.googleapis.com/auth/cloud_search.query,https://www.googleapis.com/auth/admin.directory.user.readonly,https://www.googleapis.com/auth/admin.directory.group.readonly,https://www.googleapis.com/auth/directory.readonly

Once authorized, your Gemini Enterprise App (${module.app.search_engine_id})
can securely perform contextual retrieval across your enterprise organization data.

================================================================================

EOT
}

output "slack_connector_id" {
  description = "The fully qualified ID of the Slack Data Connector."
  value       = module.slack_connector.connector_id
}

output "slack_data_store_id" {
  description = "The auto-generated Data Store ID for the Slack connector."
  value       = module.slack_connector.slack_data_store_id
}

# Jira Outputs
output "jira_connector_id" {
  description = "The fully qualified ID of the Jira Data Connector."
  value       = module.jira_connector.connector_id
}

output "jira_client_id_secret_id" {
  description = "The Secret Manager Resource Name for the Jira Client ID."
  value       = module.jira_connector.jira_client_id_secret_id
}

output "jira_client_secret_secret_id" {
  description = "The Secret Manager Resource Name for the Jira Client Secret."
  value       = module.jira_connector.jira_client_secret_secret_id
}

output "jira_instance_id_secret_id" {
  description = "The Secret Manager Resource Name for the Jira Instance ID."
  value       = module.jira_connector.jira_instance_id_secret_id
}

output "jira_data_store_id" {
  description = "The auto-generated Data Store ID for the Jira connector."
  value       = module.jira_connector.jira_data_store_id
}

# GitHub Outputs
output "github_connector_id" {
  description = "The fully qualified ID of the GitHub Data Connector."
  value       = module.github_connector.connector_id
}

output "github_client_id_secret_id" {
  description = "The Secret Manager Resource Name for the GitHub Client ID."
  value       = module.github_connector.github_client_id_secret_id
}

output "github_client_secret_secret_id" {
  description = "The Secret Manager Resource Name for the GitHub Client Secret."
  value       = module.github_connector.github_client_secret_secret_id
}

output "github_refresh_token_secret_id" {
  description = "The Secret Manager Resource Name for the GitHub Refresh Token."
  value       = module.github_connector.github_refresh_token_secret_id
}

output "github_data_store_id" {
  description = "The auto-generated Data Store ID for the GitHub connector."
  value       = module.github_connector.github_data_store_id
}

# Google Drive Outputs
output "drive_connector_id" {
  description = "The fully qualified ID of the Google Drive Data Connector."
  value       = module.drive_connector.connector_id
}

output "drive_client_id_secret_id" {
  description = "The Secret Manager Resource Name for the Google Drive Client ID."
  value       = module.drive_connector.drive_client_id_secret_id
}

output "drive_client_secret_secret_id" {
  description = "The Secret Manager Resource Name for the Google Drive Client Secret."
  value       = module.drive_connector.drive_client_secret_secret_id
}

output "drive_data_store_id" {
  description = "The auto-generated Data Store ID for the Google Drive connector."
  value       = module.drive_connector.drive_data_store_id
}

# Standalone MCP Server Outputs
output "mcp_repository_url" {
  description = "The Artifact Registry Docker repository URL for hosting MCP server images."
  value       = module.mcp.repository_url
}

output "mcp_service_url" {
  description = "The URL of the deployed Cloud Run MCP service."
  value       = module.mcp.service_url
}

output "mcp_sse_endpoint" {
  description = "The Server-Sent Events (SSE) connection endpoint of the MCP server."
  value       = module.mcp.sse_endpoint
}


