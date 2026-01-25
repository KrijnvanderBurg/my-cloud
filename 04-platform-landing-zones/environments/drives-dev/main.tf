module "vnet-spoke" {
  source = "../../modules/01-vnet-spoke"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
  }

  name                = "vnet-spoke-${local.landing_zone}-on-${local.environment}-${local.location_short}-01"
  resource_group_name = "rg-connectivity-${local.landing_zone}-${local.environment}-${local.location_short}-01"
  location            = local.location
  address_space       = [local.spoke_cidr]

  hub_vnet_id             = local.hub_vnet_id
  hub_vnet_name           = local.hub_vnet_name
  use_remote_gateways     = false # Set to true when gateways are deployed in the hub
  hub_resource_group_name = local.hub_resource_group_name

  lz_managed_subnets      = local.lz_managed_subnets
  azure_reserved_subnets  = local.azure_reserved_subnets
  azure_delegated_subnets = local.azure_delegated_subnets

  tags = local.common_tags
}

# =============================================================================
# Network Verifier
# =============================================================================
# Reachability analysis for spoke-to-hub connectivity testing.
# Run analysis from Azure Portal: Network Manager > Verifier Workspace > Run
# =============================================================================

module "network_verifier" {
  source = "../../../03-platform-connectivity/modules/03-network-verifier"

  name                    = "nm-${local.landing_zone}-${local.environment}-${local.location_short}-01"
  verifier_workspace_name = "vw-${local.landing_zone}-${local.environment}-${local.location_short}-01"
  resource_group_name     = module.vnet-spoke.resource_group_name
  location                = local.location
  scope_subscription_ids = [
    "/subscriptions/${local.connectivity_subscription_id}",
    "/subscriptions/${local.subscription_id}"
  ]

  tags = local.common_tags
}

module "network_verifier_intents_spoke" {
  source = "../../../03-platform-connectivity/modules/03b-network-verifier-intents-spoke"

  verifier_workspace_id = module.network_verifier.verifier_workspace_id

  spoke_subnet = {
    id             = module.vnet-spoke.spoke.lz_managed_subnets["snet-app-${local.landing_zone}-${local.environment}-${local.location_short}-01"].id
    name           = "snet-app-${local.landing_zone}-${local.environment}-${local.location_short}-01"
    address_prefix = module.vnet-spoke.spoke.lz_managed_subnets["snet-app-${local.landing_zone}-${local.environment}-${local.location_short}-01"].address_prefix
  }

  hub_subnet = local.hub_subnets["snet-shared-services-co-${local.environment}-${local.location_short}-01"]
}

module "key_vault" {
  source = "../../modules/key-vault"

  name                       = "kv-${local.landing_zone}-${local.environment}-${local.location_short}-01"
  resource_group_name        = "rg-security-${local.landing_zone}-${local.environment}-${local.location_short}-01"
  location                   = local.location
  tenant_id                  = local.tenant_id
  log_analytics_workspace_id = "" # Add Log Analytics workspace ID if diagnostic settings are enabled

  tags = local.common_tags
}
