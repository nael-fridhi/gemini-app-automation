# Store Jira App Client ID in Secret Manager
resource "google_secret_manager_secret" "jira_client_id" {
  provider  = google-beta
  secret_id = "jira-connector-client-id"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "jira_client_id_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.jira_client_id.id
  secret_data = var.jira_client_id
}

# Store Jira App Client Secret in Secret Manager
resource "google_secret_manager_secret" "jira_client_secret" {
  provider  = google-beta
  secret_id = "jira-connector-client-secret"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "jira_client_secret_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.jira_client_secret.id
  secret_data = var.jira_client_secret
}

# Store Jira Instance/Workspace ID in Secret Manager
resource "google_secret_manager_secret" "jira_instance_id" {
  provider  = google-beta
  secret_id = "jira-connector-instance-id"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "jira_instance_id_version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.jira_instance_id.id
  secret_data = var.jira_instance_id
}

# Provision the Google Discovery Engine Jira Data Connector
resource "google_discovery_engine_data_connector" "jira-connector" {
  provider                = google-beta
  project                 = var.project_id
  location                = var.location
  collection_id           = var.collection_id
  collection_display_name = var.collection_display_name
  data_source             = "jira"

  params = {
    instance_uri  = var.jira_instance_uri
    instance_id   = google_secret_manager_secret_version.jira_instance_id_version.name
    client_id     = google_secret_manager_secret_version.jira_client_id_version.name
    client_secret = google_secret_manager_secret_version.jira_client_secret_version.name
  }

  refresh_interval = "86400s" # 24 hours in seconds

  entities {
    entity_name = "project"
  }
  entities {
    entity_name = "issue"
  }
  entities {
    entity_name = "comment"
  }
  entities {
    entity_name = "attachment"
  }

  static_ip_enabled = false
  connector_modes   = ["FEDERATED", "ACTIONS"]
  sync_mode         = "PERIODIC"

  lifecycle {
    ignore_changes = [destination_configs]
  }
}