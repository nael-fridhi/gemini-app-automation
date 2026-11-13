# Gemini Enterprise App (Search Engine with LLM features and Intranet App Type)
resource "google_discovery_engine_search_engine" "gemini_app" {
  provider          = google-beta
  project           = var.project_id
  location          = var.location
  collection_id     = "default_collection"
  engine_id         = var.app_name
  display_name      = "${var.company_name} Gemini Enterprise"
  industry_vertical = "GENERIC"
  app_type          = "APP_TYPE_INTRANET"
  data_store_ids    = var.data_store_ids

  search_engine_config {
    search_tier                = "SEARCH_TIER_ENTERPRISE"
    search_add_ons             = ["SEARCH_ADD_ON_LLM"]
    required_subscription_tier = "SUBSCRIPTION_TIER_SEARCH_AND_ASSISTANT"
  }
}

# Project-level Access Control configuration for GSUITE (Google Workspace Identity Integration)
resource "google_discovery_engine_acl_config" "workspace_acl" {
  provider = google-beta
  project  = var.project_id
  location = var.location
  idp_config {
    idp_type = "GSUITE"
  }
}
