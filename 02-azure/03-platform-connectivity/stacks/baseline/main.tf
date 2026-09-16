# =============================================================================
# Baseline stack: platform-connectivity
# =============================================================================
# Everything that MUST exist in every environment lives here and is defined
# once. Environment roots call this stack, so a new baseline resource added
# here is inherited by all environments automatically.
#
# Environment-only resources (a dev PoC, a prod-only guardrail) do NOT belong
# here: add them as explicit module blocks in that environment's main.tf.

# =============================================================================
# Hub Network
# =============================================================================

module "hub" {
  source = "../../modules/01-hub-vnet"

  name                = "vnet-hub-co-${var.environment}-${var.location_short}-01"
  resource_group_name = "rg-connectivity-on-${var.environment}-${var.location_short}-01"
  location            = var.location
  address_space       = [var.hub_cidr]
  azure_subnets       = var.hub_azure_subnets
  managed_subnets     = var.hub_managed_subnets

  tags = var.tags
}
