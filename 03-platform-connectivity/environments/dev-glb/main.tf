# =============================================================================
# Global (glb) - Main Configuration
# =============================================================================
#
# This deployment manages cross-location_short resources:
# - Hub-to-Hub VNet peering (global peering between location_shortal hubs)
# - Hub-to-Hub Network Verifier intents
#
# NOTE: Cross-location_short Private DNS links are managed in the WEU deployment
# =============================================================================

# West Europe Hub -> Germany West Central Hub
module "hub_weu_to_hub_gwc" {
  source = "../../modules/02-vnet-peering"

  name                      = "peer-hub-weu-to-hub-gwc"
  resource_group_name       = local.hubs.weu.resource_group_name
  virtual_network_name      = local.hubs.weu.name
  remote_virtual_network_id = local.hubs.gwc.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true # Allow WEU hub to act as transit
}

# Germany West Central Hub -> West Europe Hub
module "hub_gwc_to_hub_weu" {
  source = "../../modules/02-vnet-peering"

  name                      = "peer-hub-gwc-to-hub-weu"
  resource_group_name       = local.hubs.gwc.resource_group_name
  virtual_network_name      = local.hubs.gwc.name
  remote_virtual_network_id = local.hubs.weu.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true # Allow GWC hub to act as transit
}

# =============================================================================
# Network Verifier - Hub to Hub
# =============================================================================
# Reachability analysis for cross-region hub connectivity.
# Run analysis from Azure Portal: Network Manager > Verifier Workspace > Run
# =============================================================================

module "network_verifier" {
  source = "../../modules/03-network-verifier"

  name                    = "nm-connectivity-${local.environment}-glb-01"
  verifier_workspace_name = "vw-connectivity-${local.environment}-glb-01"
  resource_group_name     = local.hubs.weu.resource_group_name
  location                = "westeurope"
  scope_subscription_ids  = ["/subscriptions/${data.terraform_remote_state.management.outputs.pl_connectivity_subscription.subscription_id}"]

  tags = local.common_tags
}

module "network_verifier_intents_hubs" {
  source = "../../modules/03a-network-verifier-intents-hubs"

  verifier_workspace_id = module.network_verifier.verifier_workspace_id

  hub_a = {
    name          = local.hubs.weu.name
    id            = local.hubs.weu.id
    address_space = local.hubs.weu.address_space
  }

  hub_b = {
    name          = local.hubs.gwc.name
    id            = local.hubs.gwc.id
    address_space = local.hubs.gwc.address_space
  }
}
