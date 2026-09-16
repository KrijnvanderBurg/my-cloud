# =============================================================================
# Environment outputs
# =============================================================================
# Forward the baseline stack outputs so downstream layers (e.g. platform
# identity) can consume them via terraform_remote_state.

# =============================================================================
# Tenant Outputs
# =============================================================================

output "tenant_id" {
  description = "The Azure AD tenant ID"
  value       = module.baseline.tenant_id
}

output "tenant_root_management_group_id" {
  description = "The fully qualified ID of the tenant root management group"
  value       = module.baseline.tenant_root_management_group_id
}

# =============================================================================
# Management Group Outputs
# =============================================================================

output "levendaal_management_group" {
  description = "KrijnvanderBurg root management group details"
  value       = module.baseline.levendaal_management_group
}

output "sandbox_management_group" {
  description = "Sandbox management group details"
  value       = module.baseline.sandbox_management_group
}

output "platform_management_group" {
  description = "Platform management group details"
  value       = module.baseline.platform_management_group
}

output "landingzone_management_group" {
  description = "Landing Zone management group details"
  value       = module.baseline.landingzone_management_group
}

# =============================================================================
# Subscription Outputs
# =============================================================================

output "pl_management_subscription" {
  description = "Platform Management subscription"
  value       = module.baseline.pl_management_subscription
}

output "pl_identity_subscription" {
  description = "Platform Identity subscription"
  value       = module.baseline.pl_identity_subscription
}

output "pl_connectivity_subscription" {
  description = "Platform Connectivity subscription"
  value       = module.baseline.pl_connectivity_subscription
}

output "alz_drive_subscription" {
  description = "ALZ Drive subscription"
  value       = module.baseline.alz_drive_subscription
}

output "plz_drives_subscription" {
  description = "Platform Landing Zone Drives subscription"
  value       = module.baseline.plz_drives_subscription
}

# =============================================================================
# Environment Information
# =============================================================================

output "environment" {
  description = "The current environment name"
  value       = module.baseline.environment
}

# =============================================================================
# Terraform State Storage
# =============================================================================

output "tfstate_storage_account" {
  description = "Terraform state storage account details"
  value       = module.baseline.tfstate_storage_account
}

output "tfstate_subscription" {
  description = "Subscription where tfstate storage account is located"
  value       = module.baseline.tfstate_subscription
}
