variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}

variable "location" {
  type        = string
  description = "The Discovery Engine location"
  default     = "global"
}

variable "collection_id" {
  type        = string
  description = "The Discovery Engine collection ID"
  default     = "jira-collection"
}

variable "collection_display_name" {
  type        = string
  description = "The display name for the jira collection"
  default     = "Jira Collection"
}

variable "jira_client_id" {
  type        = string
  description = "The Client ID of the Jira OAuth App"
}

variable "jira_client_secret" {
  type        = string
  description = "The Client Secret of the Jira OAuth App"
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

