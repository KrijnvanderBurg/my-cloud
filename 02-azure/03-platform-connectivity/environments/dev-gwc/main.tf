# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment.

module "baseline" {
  source = "../../stacks/baseline"

  environment        = local.environment
  location           = local.location
  location_short     = local.location_short
  hub_cidr           = local.hub_cidr
  hub_azure_subnets  = local.hub_azure_subnets
  hub_managed_subnets = local.hub_managed_subnets
  tags               = local.common_tags
}

# =============================================================================
# Environment-only extras (dev-gwc)
# =============================================================================
# Add resources that should exist ONLY in this environment here.
