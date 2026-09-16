# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment. Add environment-only
# resources as explicit module blocks below this call (see EXTRAS section).

module "baseline" {
  source = "../../stacks/baseline"

  environment = local.environment
  tenant_id   = local.tenant_id

  platform_management_subscription_id   = local.platform_management_subscription_id
  platform_identity_subscription_id     = local.platform_identity_subscription_id
  platform_connectivity_subscription_id = local.platform_connectivity_subscription_id
  plz_drives_subscription_id            = local.plz_drives_subscription_id
  alz_drive_subscription_id             = local.alz_drive_subscription_id

  tfstate_storage_account_name                = local.tfstate_storage_account_name
  tfstate_storage_account_resource_group_name = local.tfstate_storage_account_resource_group_name
  tfstate_subscription_id                     = local.tfstate_subscription_id
}

# =============================================================================
# State migration
# =============================================================================
# Preserve existing resources when the baseline wiring moved into the stack.

moved {
  from = module.levendaal
  to   = module.baseline.module.levendaal
}

moved {
  from = module.sandbox
  to   = module.baseline.module.sandbox
}

moved {
  from = module.platform
  to   = module.baseline.module.platform
}

moved {
  from = module.landingzone
  to   = module.baseline.module.landingzone
}

moved {
  from = module.policy_deny_delete
  to   = module.baseline.module.policy_deny_delete
}

# =============================================================================
# Environment-only extras (dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here as explicit
# module blocks. Nothing environment-specific is hidden behind conditionals.

# =============================================================================
# Policy Assignments
# =============================================================================

# Protect a management group from accidental deletions
# resource "azurerm_management_group_policy_assignment" "platform_management_deny_delete" {
#   name                 = "deny-del-pl-management"
#   display_name         = "Deny Delete Operations - Platform Management"
#   description          = "Prevents deletion of any resources under platform management management group"
#   policy_definition_id = module.policy_deny_delete.id
#   management_group_id  = module.pl_management.id
#   enforce              = true
# }

# # Protect platform identity management group from accidental deletions
# resource "azurerm_management_group_policy_assignment" "platform_identity_deny_delete" {
#   name                 = "deny-del-pl-identity"
#   display_name         = "Deny Delete Operations - Platform Identity"
#   description          = "Prevents deletion of any resources under platform identity management group"
#   policy_definition_id = module.policy_deny_delete.id
#   management_group_id  = module.pl_identity.id
#   enforce              = true
# }

# # Protect platform connectivity management group from accidental deletions
# resource "azurerm_management_group_policy_assignment" "platform_connectivity_deny_delete" {
#   name                 = "deny-del-pl-connect"
#   display_name         = "Deny Delete Operations - Platform Connectivity"
#   description          = "Prevents deletion of any resources under platform connectivity management group"
#   policy_definition_id = module.policy_deny_delete.id
#   management_group_id  = module.pl_connectivity.id
#   enforce              = true
# }

# # Protect landing zone management group from accidental deletions
# resource "azurerm_management_group_policy_assignment" "landingzone_deny_delete" {
#   name                 = "deny-del-landingzone"
#   display_name         = "Deny Delete Operations - Landing Zone"
#   description          = "Prevents deletion of any resources under landing zone management group"
#   policy_definition_id = module.policy_deny_delete.id
#   management_group_id  = module.landingzone.id
#   enforce              = true
# }
