variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}

variable "location" {
  type        = string
  description = "The Discovery Engine location"
  default     = "global"
}

variable "app_name" {
  type        = string
  description = "The unique name for the Gemini Enterprise Chat / Search Engine App."
}

variable "company_name" {
  type        = string
  description = "The company or organization name used for Discovery Engine site / chat configuration."
}
