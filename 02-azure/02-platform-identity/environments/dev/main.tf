# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment. Management-layer values
# are resolved from remote state in locals.tf and passed in explicitly. Add
# environment-only resources as explicit module blocks in the EXTRAS section.

module "baseline" {
  source = "../../stacks/baseline"

  environment    = local.environment
  location       = local.location
  location_short = local.location_short
  alert_email    = local.alert_email
  tags           = local.common_tags

  pl_connectivity_subscription_scope = local.pl_connectivity_subscription_scope
  plz_drives_subscription_scope      = local.plz_drives_subscription_scope
  pl_identity_subscription_id        = local.pl_identity_subscription_id
  tfstate_storage_account_id         = local.tfstate_storage_account_id
}

# =============================================================================
# State migration
# =============================================================================
# Preserve existing resources when the baseline wiring moved into the stack.

moved {
  from = module.sp_platform_connectivity
  to   = module.baseline.module.sp_platform_connectivity
}

moved {
  from = module.sp_alz_drives
  to   = module.baseline.module.sp_alz_drives
}

moved {
  from = module.sp_plz_drives
  to   = module.baseline.module.sp_plz_drives
}

moved {
  from = module.rbac_platform_connectivity
  to   = module.baseline.module.rbac_platform_connectivity
}

moved {
  from = module.rbac_plz_drives
  to   = module.baseline.module.rbac_plz_drives
}

moved {
  from = module.sg_rbac_platform_contributors
  to   = module.baseline.module.sg_rbac_platform_contributors
}

moved {
  from = module.monitoring_alerts
  to   = module.baseline.module.monitoring_alerts
}

# =============================================================================
# Environment-only extras (dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here as explicit
# module blocks. Nothing environment-specific is hidden behind conditionals.
