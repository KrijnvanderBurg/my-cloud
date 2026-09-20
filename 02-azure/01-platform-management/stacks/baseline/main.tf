# =============================================================================
# Baseline stack: platform-management
# =============================================================================
# Everything that MUST exist in every environment lives here and is defined
# once. Environment roots call this stack, so a new baseline resource added
# here is inherited by all environments automatically.
#
# Environment-only resources (a dev PoC, a prod-only guardrail) do NOT belong
# here: add them as explicit module blocks in that environment's main.tf.
#
# Config that legitimately differs per environment for a resource that still
# exists everywhere (e.g. a policy enforced=Deny in prod vs Audit in dev) is
# exposed as an input variable on this stack and documented in variables.tf
# and the layer README.

# Reference the existing Azure Tenant Root Group
data "azurerm_management_group" "tenant_root" {
  name = var.tenant_id
}

# =============================================================================
# Subscriptions
# =============================================================================
# Manually assigned subscriptions to management groups

data "azurerm_subscription" "platform_management" {
  subscription_id = var.platform_management_subscription_id
}

data "azurerm_subscription" "platform_identity" {
  subscription_id = var.platform_identity_subscription_id
}

data "azurerm_subscription" "platform_connectivity" {
  subscription_id = var.platform_connectivity_subscription_id
}

data "azurerm_subscription" "plz_drives" {
  subscription_id = var.plz_drives_subscription_id
}

# =============================================================================
# Management Groups
# =============================================================================

# KrijnvanderBurg Group - organisational root management group
module "krijnvanderburg" {
  source = "../../modules/01-management-group"

  name                       = "mg-krijnvanderburg-${var.environment}-na-01"
  display_name               = "mg-krijnvanderburg-${var.environment}-na-01"
  parent_management_group_id = data.azurerm_management_group.tenant_root.id
}

# Sandbox Management Group - for development and testing
# Note: Sandbox is intentionally NOT protected to allow experimentation
module "sandbox" {
  source = "../../modules/01-management-group"

  name                       = "mg-sandbox-${var.environment}-na-01"
  display_name               = "mg-sandbox-${var.environment}-na-01"
  parent_management_group_id = module.krijnvanderburg.id
}

# Platform Management Group - platform management group
module "platform" {
  source = "../../modules/01-management-group"

  name                       = "mg-platform-${var.environment}-na-01"
  display_name               = "mg-platform-${var.environment}-na-01"
  parent_management_group_id = module.krijnvanderburg.id
}

# Landing Zone Management Group - for application workloads
module "landingzone" {
  source = "../../modules/01-management-group"

  name                       = "mg-landingzone-${var.environment}-na-01"
  display_name               = "mg-landingzone-${var.environment}-na-01"
  parent_management_group_id = module.krijnvanderburg.id
}

# =============================================================================
# Policy Definitions
# =============================================================================

module "policy_deny_delete" {
  source = "../../modules/02-policy-deny-delete"

  name                = "deny-delete-operations"
  display_name        = "Deny Delete Operations"
  management_group_id = module.krijnvanderburg.id
}
