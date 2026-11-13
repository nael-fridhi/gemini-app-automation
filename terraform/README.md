# Terraform Configuration: Gemini Enterprise App

This directory contains the Terraform configuration to provision a single-project **Gemini Enterprise App** (Vertex AI Agent Builder / Discovery Engine), Google Workspace connectors, optional enterprise connectors (Slack, Jira, GitHub), and supporting Cloud Run infrastructure.

For architectural topology and design details, see [Standalone Architecture Documentation](../docs/architectures/README.md).

---

## 📦 Module Structure

```text
terraform/
├── main.tf                    # Root orchestration and IAM bindings
├── variables.tf               # Input variable definitions
├── outputs.tf                 # Output definitions and DWD instructions
├── versions.tf                # Provider and Terraform version constraints
├── terraform.tfvars.example   # Example variables template
└── modules/
    ├── app/                   # Gemini Enterprise App (Search Engine) & Workspace ACL
    ├── connectors/
    │   ├── workspace/         # Google Workspace unstructured Data Store
    │   ├── drive/             # Google Drive OAuth connector
    │   ├── github/            # GitHub OAuth connector
    │   ├── jira/              # Jira OAuth connector
    │   └── slack/             # Slack OAuth connector
    └── mcp/                   # Artifact Registry & Cloud Run MCP Server
```

---

## 📋 Requirements

| Name | Version |
| :--- | :--- |
| **Terraform** | `>= 1.0` |
| **google** | `~> 7.0` |
| **google-beta** | `~> 7.0` |

### Required Permissions & Roles
- GCP project owner or editor with permissions to enable APIs and manage IAM (`roles/resourcemanager.projectIamAdmin`, `roles/discoveryengine.admin`, `roles/secretmanager.admin`).
- Google Workspace Super Admin access (to grant Domain-Wide Delegation in the Workspace Admin Console).

---

## ⚙️ Input Variables

| Variable | Description | Type | Default | Required |
| :--- | :--- | :--- | :--- | :---: |
| `project_id` | Google Cloud Project ID | `string` | `"nsandbox"` | Yes |
| `region` | Google Cloud region for regional resources | `string` | `"us-central1"` | No |
| `location` | Discovery Engine location (`global`, `us`, or `eu`) | `string` | `"global"` | No |
| `app_name` | Engine ID for the Gemini Enterprise App | `string` | `"gemini-workspace-app"` | No |
| `company_name` | Organization name for chat configuration | `string` | `"naelf"` | No |
| `workspace_admin_email` | Workspace super admin email for DWD | `string` | `"admin@naelf.altostrat.com"` | Yes |
| `drive_client_id` | Client ID for Google Drive connector | `string` | `""` | No |
| `drive_client_secret` | Client Secret for Google Drive connector | `string` | `""` | No |
| `slack_client_id` | Client ID for Slack connector | `string` | `""` | No |
| `slack_client_secret` | Client Secret for Slack connector | `string` | `""` | No |
| `jira_client_id` | Client ID for Jira OAuth app | `string` | `""` | No |
| `jira_client_secret` | Client Secret for Jira OAuth app | `string` | `""` | No |
| `jira_instance_uri` | Base URI of Jira instance | `string` | `"https://example.atlassian.net"` | No |
| `jira_instance_id` | Cloud Workspace UUID for Jira | `string` | `"00000000-0000-0000-0000-000000000000"` | No |
| `github_client_id` | Client ID for GitHub connector | `string` | `""` | No |
| `github_client_secret` | Client Secret for GitHub connector | `string` | `""` | No |
| `github_refresh_token` | Refresh token for GitHub connector | `string` | `"placeholder-github-refresh-token"` | No |
| `mcp_service_name` | Cloud Run service name for MCP Server | `string` | `"simple-helper-mcp"` | No |

---

## 📤 Key Outputs

| Output | Description |
| :--- | :--- |
| `gemini_chat_app_id` | Engine ID of the provisioned Gemini Enterprise App |
| `workspace_data_store_id` | Data Store ID for unstructured Google Workspace content |
| `connector_service_account_email` | Dedicated service account email for connectors |
| `connector_service_account_unique_id` | OAuth Client ID (Unique ID) needed for Google Workspace DWD |
| `google_workspace_dwd_instructions` | Step-by-step instructions and scopes printed at apply time |
| `mcp_service_url` | Deployed Cloud Run URL for the MCP server |

---

## 🚀 Deployment

### 1. Configure Variables
Copy the template and populate required values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

### 2. Initialize and Apply

```bash
terraform init
terraform plan
terraform apply
```

### 3. Post-Deployment: Workspace Domain-Wide Delegation (DWD)
After `terraform apply` finishes, authorize the connector service account:

1. Retrieve the OAuth client ID from outputs:
   ```bash
   terraform output connector_service_account_unique_id
   ```
2. Navigate to [Google Workspace Admin Console](https://admin.google.com) > **Security** > **Access and data control** > **API controls** > **Manage Domain Wide Delegation**.
3. Add a new API client with the Unique ID and authorized OAuth scopes:
   ```text
   https://www.googleapis.com/auth/drive.readonly,
   https://www.googleapis.com/auth/cloud_search.query,
   https://www.googleapis.com/auth/admin.directory.user.readonly,
   https://www.googleapis.com/auth/admin.directory.group.readonly,
   https://www.googleapis.com/auth/directory.readonly
   ```

---

## 🛠️ Troubleshooting

### Quota Project Requirement
Discovery Engine APIs require a quota project when authenticating via local Application Default Credentials (ADC). The provider in `versions.tf` handles this by setting:

```hcl
provider "google" {
  user_project_override = true
  billing_project       = var.project_id
}
```

Ensure your active gcloud account has `roles/serviceusage.serviceUsageConsumer` (`serviceusage.services.use`) on the target project.
