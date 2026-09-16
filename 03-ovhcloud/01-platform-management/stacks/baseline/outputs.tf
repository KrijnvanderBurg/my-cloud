# =============================================================================
# Platform Management Baseline Stack - Outputs
# =============================================================================
# All outputs from the baseline stack. Environment root forwards these.

output "project" {
  description = "OVHcloud Public Cloud project details"
  value = {
    id          = data.ovh_cloud_project.platform_management.service_name
    description = data.ovh_cloud_project.platform_management.description
  }
}
