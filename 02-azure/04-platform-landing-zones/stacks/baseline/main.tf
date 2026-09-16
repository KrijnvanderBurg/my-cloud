# =============================================================================
# Baseline stack: platform-landing-zones
# =============================================================================
# Everything that MUST exist in every environment lives here and is defined
# once. Environment roots call this stack, so a new baseline resource added
# here is inherited by all environments automatically.
#
# Environment-only resources (a dev PoC, a prod-only guardrail) do NOT belong
# here: add them as explicit module blocks in that environment's main.tf.

# =============================================================================
# Landing Zone
# =============================================================================
# Complete landing zone with Log Analytics, Spoke VNet, and Key Vault.

module "landing_zone" {
  source = "../../modules/01-base-package"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
  }

  # Naming inputs
  landing_zone   = var.landing_zone
  environment    = var.environment
  location_short = var.location_short

  # Core configuration
  location      = var.location
  address_space = [var.spoke_cidr]
  tenant_id     = var.tenant_id

  # Hub peering
  hub_vnet_id             = var.hub_vnet_id
  hub_vnet_name           = var.hub_vnet_name
  hub_resource_group_name = var.hub_resource_group_name

  # Subnets
  lz_managed_subnets      = var.lz_managed_subnets
  azure_reserved_subnets  = var.azure_reserved_subnets
  azure_delegated_subnets = var.azure_delegated_subnets

  tags = var.tags
}

# =============================================================================
# Moved Resources
# =============================================================================
# Handle resources that were moved from stack level to module level

moved {
  from = azurerm_resource_group.this
  to   = module.landing_zone.azurerm_resource_group.this
}

moved {
  from = azurerm_monitor_diagnostic_setting.key_vault
  to   = module.landing_zone.azurerm_monitor_diagnostic_setting.key_vault
}

moved {
  from = azurerm_log_analytics_data_export_rule.to_storage
  to   = module.landing_zone.azurerm_log_analytics_data_export_rule.to_storage
}

moved {
  from = azurerm_monitor_diagnostic_setting.vnet
  to   = module.landing_zone.azurerm_monitor_diagnostic_setting.vnet
}
