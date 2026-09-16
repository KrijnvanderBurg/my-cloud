# =============================================================================
# Environment outputs
# =============================================================================
# Forward the baseline stack outputs so consumers keep a stable interface.

# =============================================================================
# Service Principal Outputs
# =============================================================================
output "sp_platform_connectivity" {
  description = "Platform connectivity service principal for GitHub Actions OIDC"
  value       = module.baseline.sp_platform_connectivity
}

output "sp_plz_drives" {
  description = "PLZ drives service principal for GitHub Actions OIDC"
  value       = module.baseline.sp_plz_drives
}

# =============================================================================
# RBAC Role Assignment Outputs
# =============================================================================
output "rbac_platform_connectivity" {
  description = "Role assignment IDs for platform connectivity service principal"
  value       = module.baseline.rbac_platform_connectivity
}

output "rbac_plz_drives" {
  description = "Role assignment IDs for PLZ drives service principal"
  value       = module.baseline.rbac_plz_drives
}

# =============================================================================
# Security Group Outputs
# =============================================================================

output "sg_rbac_platform_contributors" {
  description = "Platform contributors security group for Azure RBAC assignments"
  value       = module.baseline.sg_rbac_platform_contributors
}

# =============================================================================
# Monitoring Outputs
# =============================================================================

output "action_group_identity_alerts" {
  description = "Identity alerts action group details"
  value       = module.baseline.action_group_identity_alerts
}

output "alert_rule_admin_activity" {
  description = "Administrative activity alert rule details"
  value       = module.baseline.alert_rule_admin_activity
}

output "monitoring_resource_group" {
  description = "Monitoring resource group name"
  value       = module.baseline.monitoring_resource_group
}
