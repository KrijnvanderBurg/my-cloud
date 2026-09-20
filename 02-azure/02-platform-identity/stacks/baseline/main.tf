# =============================================================================
# Baseline stack: platform-identity
# =============================================================================
# Everything that MUST exist in every environment lives here and is defined
# once. Environment roots call this stack, so a new baseline resource added
# here is inherited by all environments automatically.
#
# Environment-only resources (a dev PoC, a prod-only guardrail) do NOT belong
# here: add them as explicit module blocks in that environment's main.tf.
#
# Config that legitimately differs per environment for a resource that still
# exists everywhere is exposed as an input variable on this stack and
# documented in variables.tf and the layer README.

# =============================================================================
# Service Principals (Federated for GitHub Actions)
# =============================================================================
# No SP for platform management to prevent dependency conflicts
# No SP for platform identity, also to prevent dependency conflicts and Identity
# has elevated permissions that we don't want to automate creation for.

module "sp_platform_connectivity" {
  source = "../../modules/01-service-principal-federated"

  name = "sp-pl-connectivity-on-${var.environment}-na-01"
  subjects = [
    "repo:KrijnvanderBurg/my-cloud:environment:${var.environment}"
  ]
}

module "sp_plz_drives" {
  source = "../../modules/01-service-principal-federated"

  name = "sp-plz-drives-on-${var.environment}-na-01"
  subjects = [
    "repo:KrijnvanderBurg/my-cloud:environment:${var.environment}"
  ]
}

# =============================================================================
# RBAC Role Assignments
# =============================================================================
module "rbac_platform_connectivity" {
  source = "../../modules/02a-rbac-pl-connectivity"

  principal_id                       = module.sp_platform_connectivity.object_id
  pl_connectivity_subscription_scope = var.pl_connectivity_subscription_scope
  plz_drives_subscription_scope      = var.plz_drives_subscription_scope
  tfstate_storage_account_id         = var.tfstate_storage_account_id

  depends_on = [module.sp_platform_connectivity]
}

module "rbac_plz_drives" {
  source = "../../modules/02b-rbac-plz"

  principal_id                    = module.sp_plz_drives.object_id
  plz_drives_subscription_scope   = var.plz_drives_subscription_scope
  connectivity_subscription_scope = var.pl_connectivity_subscription_scope
  tfstate_storage_account_id      = var.tfstate_storage_account_id

  depends_on = [module.sp_plz_drives]
}

# =============================================================================
# Security Groups
# =============================================================================
module "sg_rbac_platform_contributors" {
  source = "../../modules/03-entra-group"

  display_name       = "sg-rbac-pl-contributors-${var.environment}-na-01"
  description        = "Members have Contributor access to platform subscriptions via Azure RBAC"
  assignable_to_role = false
}

# =============================================================================
# Monitoring Alerts
# =============================================================================

module "monitoring_alerts" {
  source = "../../modules/04-monitoring-alerts"

  environment     = var.environment
  location        = var.location
  location_short  = var.location_short
  subscription_id = var.pl_identity_subscription_id
  alert_email     = var.alert_email
  tags            = var.tags
}
