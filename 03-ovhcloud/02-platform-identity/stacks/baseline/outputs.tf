# =============================================================================
# Platform Identity Baseline Stack - Outputs
# =============================================================================
# All outputs from the baseline stack. Environment root forwards these.

# =============================================================================
# Group Outputs
# =============================================================================
output "groups" {
  description = "Identity groups keyed by name, with their IAM URNs"
  value = {
    for name, mod in module.group : name => {
      name = mod.name
      urn  = mod.urn
    }
  }
}

# =============================================================================
# User Outputs
# =============================================================================
output "users" {
  description = "Identity users keyed by login (no credentials exposed)"
  value = {
    for login, mod in module.user : login => {
      login  = mod.login
      email  = mod.email
      urn    = mod.urn
      status = mod.status
    }
  }
}

# =============================================================================
# Service Account Outputs
# =============================================================================
# Only the non-secret identity URN is exposed. The client_id/client_secret are
# intentionally NOT output; retrieve the secret once from state during bootstrap
# (see README) and store it in a secret manager.
output "service_accounts" {
  description = "Service account identity URNs keyed by name (no credentials exposed)"
  value = {
    for name, mod in module.service_account : name => {
      name     = mod.name
      identity = mod.identity
    }
  }
}

# =============================================================================
# IAM Policy Outputs
# =============================================================================
output "iam_policies" {
  description = "IAM policy IDs by policy name"
  value = {
    (module.policy_human_platform_admin.name) = module.policy_human_platform_admin.id
    (module.policy_human_developer.name)      = module.policy_human_developer.id
    (module.policy_human_read_only.name)      = module.policy_human_read_only.id
    (module.policy_terraform.name)            = module.policy_terraform.id
  }
}
