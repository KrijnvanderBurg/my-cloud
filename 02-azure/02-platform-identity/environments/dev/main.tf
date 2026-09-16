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
# Environment-only extras (dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here as explicit
# module blocks. Nothing environment-specific is hidden behind conditionals.
