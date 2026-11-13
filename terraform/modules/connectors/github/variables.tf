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
  default     = "github-collection"
}

variable "collection_display_name" {
  type        = string
  description = "The display name for the github collection"
  default     = "GitHub Collection"
}

variable "github_client_id" {
  type        = string
  description = "The Client ID of the GitHub OAuth App"
}

variable "github_client_secret" {
  type        = string
  description = "The Client Secret of the GitHub OAuth App"
  sensitive   = true
}

variable "github_refresh_token" {
  type        = string
  description = "The OAuth Refresh Token of the GitHub App"
  default     = "placeholder-github-refresh-token"
  sensitive   = true
}

