# =============================================================================
# Environment outputs
# =============================================================================
# Forward the baseline stack outputs.

# =============================================================================
# Group Outputs
# =============================================================================

output "groups" {
  description = "Identity groups keyed by name, with their IAM URNs"
  value       = module.baseline.groups
}

# =============================================================================
# User Outputs
# =============================================================================

output "users" {
  description = "Identity users keyed by login (no credentials exposed)"
  value       = module.baseline.users
}

# =============================================================================
# Service Account Outputs
# =============================================================================

output "service_accounts" {
  description = "Service account identity URNs keyed by name (no credentials exposed)"
  value       = module.baseline.service_accounts
}

# =============================================================================
# IAM Policy Outputs
# =============================================================================

output "iam_policies" {
  description = "IAM policy IDs by policy name"
  value       = module.baseline.iam_policies
}
