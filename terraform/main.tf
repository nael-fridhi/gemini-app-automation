# Enable necessary Google Cloud APIs for Discovery Engine and Enterprise Connectors
resource "google_project_service" "discovery_engine" {
  project                    = var.project_id
  service                    = "discoveryengine.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "cloud_search" {
  project                    = var.project_id
  service                    = "cloudsearch.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "secret_manager" {
  project                    = var.project_id
  service                    = "secretmanager.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

# Dedicated Service Account for the Google Workspace Connector Ingestion & Querying
resource "google_service_account" "connector_sa" {
  account_id   = "gemini-workspace-connector"
  display_name = "Gemini Enterprise Workspace Connector Service Account"
  description  = "Service account utilized for secure Google Workspace ingestion and Discovery Engine data synchronization"
  project      = var.project_id
}

resource "google_project_iam_member" "connector_discovery_editor" {
  project = var.project_id
  role    = "roles/discoveryengine.editor"
  member  = "serviceAccount:${google_service_account.connector_sa.email}"
}

resource "google_project_iam_member" "connector_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.connector_sa.email}"
}

module "workspace_store" {
  source       = "./modules/connectors/workspace"
  project_id   = var.project_id
  location     = var.location
  app_name     = var.app_name
  company_name = var.company_name

  depends_on = [
    google_project_service.discovery_engine
  ]
}

module "slack_connector" {
  source                  = "./modules/connectors/slack"
  project_id              = var.project_id
  location                = var.location
  collection_id           = "slack-collection"
  collection_display_name = "Slack Collection"
  slack_client_id         = var.slack_client_id
  slack_client_secret     = var.slack_client_secret

  depends_on = [
    google_project_service.discovery_engine,
    google_project_service.secret_manager
  ]
}

module "jira_connector" {
  source                  = "./modules/connectors/jira"
  project_id              = var.project_id
  location                = var.location
  collection_id           = "jira-collection"
  collection_display_name = "Jira Collection"
  jira_client_id          = var.jira_client_id
  jira_client_secret      = var.jira_client_secret
  jira_instance_uri       = var.jira_instance_uri
  jira_instance_id        = var.jira_instance_id

  depends_on = [
    google_project_service.discovery_engine,
    google_project_service.secret_manager
  ]
}

module "github_connector" {
  source                  = "./modules/connectors/github"
  project_id              = var.project_id
  location                = var.location
  collection_id           = "github-collection"
  collection_display_name = "GitHub Collection"
  github_client_id        = var.github_client_id
  github_client_secret    = var.github_client_secret
  github_refresh_token    = var.github_refresh_token

  depends_on = [
    google_project_service.discovery_engine,
    google_project_service.secret_manager
  ]
}

module "drive_connector" {
  source                  = "./modules/connectors/drive"
  project_id              = var.project_id
  location                = var.location
  collection_id           = "drive-collection"
  collection_display_name = "Google Drive Collection"
  drive_client_id         = var.drive_client_id
  drive_client_secret     = var.drive_client_secret
  workspace_admin_email   = var.workspace_admin_email

  depends_on = [
    google_project_service.discovery_engine,
    google_project_service.secret_manager
  ]
}


module "app" {
  source       = "./modules/app"
  project_id   = var.project_id
  location     = var.location
  app_name     = var.app_name
  company_name = var.company_name
  data_store_ids = [
    module.workspace_store.data_store_id,
    "people-search-data-connector_1781167136146_users",
    module.slack_connector.slack_data_store_id,
    module.jira_connector.jira_data_store_id,
    module.github_connector.github_data_store_id,
    module.drive_connector.drive_data_store_id
  ]

  depends_on = [
    module.workspace_store,
    module.slack_connector,
    module.jira_connector,
    module.github_connector,
    module.drive_connector
  ]
}


# Fetch details about the current GCP project (for the project number)
data "google_project" "project" {}

# Grant Discovery Engine Service Agent permissions to impersonate and create tokens on the Connector Service Account
resource "google_service_account_iam_member" "discovery_engine_token_creator" {
  service_account_id = google_service_account.connector_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-discoveryengine.iam.gserviceaccount.com"
}

# Grant Discovery Engine Service Agent permissions to create tokens at the project level.
# In many cases, background data sync services check for project-level token creation permissions.
resource "google_project_iam_member" "discovery_engine_project_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-discoveryengine.iam.gserviceaccount.com"
}

# Grant Discovery Engine Service Agent permissions to access and retrieve Secret Manager secrets.
# Required for SaaS data connectors (Jira, GitHub, Drive) to fetch OAuth client credentials.
resource "google_project_iam_member" "discovery_engine_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-discoveryengine.iam.gserviceaccount.com"
}


