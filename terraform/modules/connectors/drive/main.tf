# Store Google Drive App Client ID in Secret Manager
resource "google_secret_manager_secret" "drive_client_id" {
  provider  = google-beta
  secret_id = "drive-connector-client-id"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "drive_client_id_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.drive_client_id.id
  secret_data = var.drive_client_id
}

# Store Google Drive App Client Secret in Secret Manager
resource "google_secret_manager_secret" "drive_client_secret" {
  provider  = google-beta
  secret_id = "drive-connector-client-secret"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "drive_client_secret_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.drive_client_secret.id
  secret_data = var.drive_client_secret
}

# Provision the Google Discovery Engine Google Drive Data Connector
resource "google_discovery_engine_data_connector" "drive-connector" {
  provider                = google-beta
  project                 = var.project_id
  location                = var.location
  collection_id           = var.collection_id
  collection_display_name = var.collection_display_name
  data_source             = "google_drive"

  params = {
    client_id     = google_secret_manager_secret_version.drive_client_id_version.name
    client_secret = google_secret_manager_secret_version.drive_client_secret_version.name
  }

  refresh_interval = "86400s" # 24 hours in seconds

  entities {
    entity_name = "file"
  }

  static_ip_enabled = false
  connector_modes   = ["FEDERATED", "ACTIONS"]
  sync_mode         = "PERIODIC"

  lifecycle {
    ignore_changes = [destination_configs]
  }
}
