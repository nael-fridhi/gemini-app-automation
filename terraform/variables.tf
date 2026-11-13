variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID where the Gemini Enterprise App (Vertex AI Agent Builder) resources will be deployed."
  default     = "nsandbox"
}

variable "region" {
  type        = string
  description = "The Google Cloud region for compute and API operations (e.g., us-central1)."
  default     = "us-central1"
}

variable "location" {
  type        = string
  description = "The Discovery Engine location. Must be either 'global', 'us', or 'eu'."
  default     = "global"
}

variable "app_name" {
  type        = string
  description = "The unique name for the Gemini Enterprise Chat / Search Engine App."
  default     = "gemini-workspace-app"
}

variable "company_name" {
  type        = string
  description = "The company or organization name used for Discovery Engine site / chat configuration."
  default     = "naelf"
}

variable "workspace_admin_email" {
  type        = string
  description = "The email address of the Google Workspace super admin authorized for Domain Wide Delegation."
  default     = "admin@naelf.altostrat.com"
}

variable "slack_client_id" {
  type        = string
  description = "The Client ID of the Slack App for the Discovery Engine Slack connector."
  default     = ""
}

variable "slack_client_secret" {
  type        = string
  description = "The Client Secret of the Slack App for the Discovery Engine Slack connector."
  default     = ""
  sensitive   = true
}

# Jira Connector Credentials
variable "jira_client_id" {
  type        = string
  description = "The Client ID of the Jira OAuth App."
  default     = ""
}

variable "jira_client_secret" {
  type        = string
  description = "The Client Secret of the Jira OAuth App."
  default     = ""
  sensitive   = true
}

variable "jira_instance_uri" {
  type        = string
  description = "The Base URI of your Jira/Atlassian instance (e.g. https://your-domain.atlassian.net)"
  default     = "https://example.atlassian.net"
}

variable "jira_instance_id" {
  type        = string
  description = "The Cloud Workspace ID/Instance ID of your Jira deployment (must be a valid UUID)"
  default     = "00000000-0000-0000-0000-000000000000"
}

# GitHub Connector Credentials
variable "github_client_id" {
  type        = string
  description = "The Client ID of the GitHub OAuth App."
  default     = ""
}

variable "github_client_secret" {
  type        = string
  description = "The Client Secret of the GitHub OAuth App."
  default     = ""
  sensitive   = true
}

variable "github_refresh_token" {
  type        = string
  description = "The OAuth Refresh Token of the GitHub App."
  default     = "placeholder-github-refresh-token"
  sensitive   = true
}

# Google Drive Connector Credentials
variable "drive_client_id" {
  type        = string
  description = "The Client ID of the Google Drive OAuth App."
  default     = ""
}

variable "drive_client_secret" {
  type        = string
  description = "The Client Secret of the Google Drive OAuth App."
  default     = ""
  sensitive   = true
}

# Standalone MCP Server Configuration
variable "mcp_service_name" {
  type        = string
  description = "The name of the Cloud Run service for the standalone MCP Server."
  default     = "simple-helper-mcp"
}

# Standalone ADK Agent Configuration
variable "agent_display_name" {
  type        = string
  description = "The display name of the ADK Agent running on Google Cloud Agent Runtime."
  default     = "simple-helper-agent"
}






