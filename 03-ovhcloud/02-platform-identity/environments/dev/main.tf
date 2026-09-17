# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment. Identity configuration
# is fully data-driven via locals.tf (users, groups, service accounts, IAM
# policies).

module "baseline" {
  source = "../../stacks/baseline"

  environment      = local.environment
  users            = local.users
  service_accounts = local.service_accounts
  groups           = local.groups
  policy_actions   = local.policy_actions
  common_tags      = local.common_tags
}

# =============================================================================
# Environment-only extras (dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here as explicit
# module blocks. Nothing environment-specific is hidden behind conditionals.
