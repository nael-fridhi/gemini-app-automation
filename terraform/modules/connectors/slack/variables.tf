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
  default     = "slack-collection"
}

variable "collection_display_name" {
  type        = string
  description = "The display name for the slack dataconnector"
  default     = "Slack Collection"
}

variable "slack_client_id" {
  type        = string
  description = "The Client ID of the Slack App"
}

variable "slack_client_secret" {
  type        = string
  description = "The Client Secret of the Slack App"
  sensitive   = true
}
