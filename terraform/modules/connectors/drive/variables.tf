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
  default     = "drive-collection"
}

variable "collection_display_name" {
  type        = string
  description = "The display name for the drive collection"
  default     = "Google Drive Collection"
}

variable "drive_client_id" {
  type        = string
  description = "The Client ID of the Google Drive OAuth App"
  default     = ""
}

variable "drive_client_secret" {
  type        = string
  description = "The Client Secret of the Google Drive OAuth App"
  default     = ""
  sensitive   = true
}

variable "workspace_admin_email" {
  type        = string
  description = "The support email address for the OAuth Consent Screen (IAP Brand)"
}

