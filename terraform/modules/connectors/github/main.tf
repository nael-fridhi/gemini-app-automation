# Store GitHub App Client ID in Secret Manager
resource "google_secret_manager_secret" "github_client_id" {
  provider  = google-beta
  secret_id = "github-connector-client-id"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github_client_id_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.github_client_id.id
  secret_data = var.github_client_id
}

# Store GitHub App Client Secret in Secret Manager
resource "google_secret_manager_secret" "github_client_secret" {
  provider  = google-beta
  secret_id = "github-connector-client-secret"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github_client_secret_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.github_client_secret.id
  secret_data = var.github_client_secret
}

# Store GitHub App Refresh Token in Secret Manager
resource "google_secret_manager_secret" "github_refresh_token" {
  provider  = google-beta
  secret_id = "github-connector-refresh-token"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github_refresh_token_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.github_refresh_token.id
  secret_data = var.github_refresh_token
}

# Provision the Google Discovery Engine GitHub Data Connector
resource "google_discovery_engine_data_connector" "github-connector" {
  provider                = google-beta
  project                 = var.project_id
  location                = var.location
  collection_id           = var.collection_id
  collection_display_name = var.collection_display_name
  data_source             = "github"

  params = {
    client_id     = google_secret_manager_secret_version.github_client_id_version.name
    client_secret = google_secret_manager_secret_version.github_client_secret_version.name
    refresh_token = google_secret_manager_secret_version.github_refresh_token_version.name
  }

  refresh_interval = "86400s" # 24 hours in seconds

  entities {
    entity_name = "repository"
  }
  entities {
    entity_name = "issue"
  }
  entities {
    entity_name = "pull_request"
  }

  static_ip_enabled = false
  connector_modes   = ["FEDERATED", "ACTIONS"]
  sync_mode         = "PERIODIC"

  lifecycle {
    ignore_changes = [destination_configs]
  }
}
