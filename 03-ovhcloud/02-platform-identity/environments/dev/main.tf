# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment. Identity configuration
# is fully data-driven via locals.tf (users, groups, service accounts, IAM
# policies).

module "baseline" {
  source = "../../stacks/baseline"

  environment    = local.environment
  users          = local.users
  service_accounts = local.service_accounts
  groups         = local.groups
  policy_actions = local.policy_actions
  common_tags    = local.common_tags
}

# =============================================================================
# State migration
# =============================================================================
# Preserve existing resources when identity modules moved into the baseline stack.

moved {
  from = module.group
  to   = module.baseline.module.group
}

moved {
  from = module.user
  to   = module.baseline.module.user
}

moved {
  from = module.service_account
  to   = module.baseline.module.service_account
}

moved {
  from = module.policy_human_platform_admin
  to   = module.baseline.module.policy_human_platform_admin
}

moved {
  from = module.policy_human_developer
  to   = module.baseline.module.policy_human_developer
}

moved {
  from = module.policy_human_read_only
  to   = module.baseline.module.policy_human_read_only
}

moved {
  from = module.policy_terraform
  to   = module.baseline.module.policy_terraform
}

# =============================================================================
# Environment-only extras (dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here as explicit
# module blocks. Nothing environment-specific is hidden behind conditionals.
