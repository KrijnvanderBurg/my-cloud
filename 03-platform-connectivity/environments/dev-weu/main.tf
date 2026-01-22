# =============================================================================
# West Europe (weu) - Main Configuration
# =============================================================================

# =============================================================================
# Hub Network
# =============================================================================

module "hub" {
  source = "../../modules/hub-network"

  name                = "vnet-hub-co-${local.environment}-${local.region}-01"
  resource_group_name = "rg-connectivity-on-${local.environment}-${local.region}-01"
  location            = local.location
  address_space       = [local.hub_cidr]
  azure_subnets       = local.hub_azure_subnets
  managed_subnets     = local.hub_managed_subnets

  tags = local.common_tags
}

# =============================================================================
# Spoke Networks
# =============================================================================

module "spoke" {
  source   = "../../modules/spoke-network"
  for_each = local.spoke_cidrs

  name                = "vnet-${each.key}-co-${local.environment}-${local.region}-01"
  resource_group_name = module.hub.resource_group_name
  location            = local.location
  address_space       = [each.value]

  hub_vnet_name           = module.hub.name
  hub_vnet_id             = module.hub.id
  hub_resource_group_name = module.hub.resource_group_name

  use_remote_gateways       = false
  hub_allow_gateway_transit = true
  private_dns_zones         = []

  tags = merge(
    local.common_tags,
    {}
  )
}

# =============================================================================
# Private DNS Zones (CENTRALIZED - Global DNS Management)
# =============================================================================

module "private_dns" {
  source   = "../../modules/private-dns-zone"
  for_each = toset(local.private_dns_zones)

  name                = each.value
  resource_group_name = module.hub.resource_group_name

  virtual_network_links = {
    hub-weu = local.hub_weu_id
    hub-gwc = local.hub_gwc_id
  }

  tags = merge(
    local.common_tags,
    {
      "dns-scope"  = "global"
      "managed-in" = "weu"
    }
  )
}

# =============================================================================
# Landing Zone Spoke Networks (deployed in LZ subscriptions)
# =============================================================================

module "lz_spoke" {
  source   = "../../modules/spoke-network"
  for_each = local.lz_spoke_cidrs

  name                = "vnet-${each.key}-on-${local.environment}-${local.region}-01"
  resource_group_name = "rg-connectivity-${each.key}-${local.environment}-${local.region}-01"
  location            = local.location
  address_space       = [each.value]

  hub_vnet_name           = module.hub.name
  hub_vnet_id             = module.hub.id
  hub_resource_group_name = module.hub.resource_group_name
  private_dns_zones       = toset(local.private_dns_zones)

  use_remote_gateways       = false
  hub_allow_gateway_transit = true

  tags = merge(local.common_tags, {
    landing_zone = each.key
  })
}
