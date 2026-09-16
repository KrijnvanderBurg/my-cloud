# =============================================================================
# Platform Management Baseline Stack
# =============================================================================
# Shared resources for platform management across all environments.
# All variables passed from the environment to ensure env-specific values
# (e.g., project IDs) are declaratively supplied with no defaults.

# =============================================================================
# OVHcloud Public Cloud Project
# =============================================================================
# Query the project to validate it exists and expose its metadata.
data "ovh_cloud_project" "platform_management" {
  service_name = var.project_id
}
