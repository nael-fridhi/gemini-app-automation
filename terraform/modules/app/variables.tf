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
  description = "The unique name for the Gemini Enterprise App"
}

variable "company_name" {
  type        = string
  description = "The company name"
}

variable "data_store_ids" {
  type        = list(string)
  description = "List of Data Store IDs to bind to this Search Engine App"
}
