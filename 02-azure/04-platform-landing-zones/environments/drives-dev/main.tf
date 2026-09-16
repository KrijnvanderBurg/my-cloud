# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment.

module "baseline" {
  source = "../../stacks/baseline"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
  }

  landing_zone            = local.landing_zone
  environment             = local.environment
  location                = local.location
  location_short          = local.location_short
  tenant_id               = local.tenant_id
  spoke_cidr              = local.spoke_cidr
  hub_vnet_id             = local.hub_vnet_id
  hub_vnet_name           = local.hub_vnet_name
  hub_resource_group_name = local.hub_resource_group_name
  lz_managed_subnets      = local.lz_managed_subnets
  azure_reserved_subnets  = local.azure_reserved_subnets
  azure_delegated_subnets = local.azure_delegated_subnets
  tags                    = local.common_tags
}

# =============================================================================
# Environment-only extras (drives-dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here.
