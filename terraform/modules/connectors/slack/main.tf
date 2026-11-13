# Create Secret Manager secrets to securely store the Slack OAuth credentials
resource "google_secret_manager_secret" "slack_client_id" {
  provider  = google-beta
  project   = var.project_id
  secret_id = "slack-connector-client-id"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "slack_client_id_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.slack_client_id.id
  secret_data = var.slack_client_id
}

resource "google_secret_manager_secret" "slack_client_secret" {
  provider  = google-beta
  project   = var.project_id
  secret_id = "slack-connector-client-secret"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "slack_client_secret_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.slack_client_secret.id
  secret_data = var.slack_client_secret
}

# Provision the Google Discovery Engine Slack Data Connector
resource "google_discovery_engine_data_connector" "slack-connector" {
  provider                = google-beta
  project                 = var.project_id
  location                = var.location
  collection_id           = var.collection_id
  collection_display_name = var.collection_display_name
  data_source             = "slack"

  params = {
    unused_auth_param = "true"
  }

  refresh_interval = "86400s" # 24 hours in seconds

  # Map core Slack entities for search and indexing
  entities {
    entity_name = "conversation"
  }
  entities {
    entity_name = "message"
  }
  entities {
    entity_name = "file"
  }

  static_ip_enabled = false
  connector_modes   = ["FEDERATED"]

  lifecycle {
    ignore_changes = [destination_configs]
  }
}