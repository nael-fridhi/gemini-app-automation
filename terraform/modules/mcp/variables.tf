variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}

variable "region" {
  type        = string
  description = "The region to deploy the Cloud Run service to"
  default     = "us-central1"
}

variable "service_name" {
  type        = string
  description = "The name of the Cloud Run service"
}

variable "repository_id" {
  type        = string
  description = "The ID of the Artifact Registry repository to create"
}

variable "image_url" {
  type        = string
  description = "The Docker image URL to deploy to Cloud Run (defaults to a safe public Hello container for initial provisioning bootstrap)"
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}
