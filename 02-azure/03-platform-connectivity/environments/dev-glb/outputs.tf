# =============================================================================
# Environment outputs
# =============================================================================
# Forward baseline outputs and add environment-specific outputs.

# =============================================================================
# Hub Network Outputs (from baseline)
# =============================================================================

output "hub" {
  description = "Hub VNet details"
  value       = module.baseline.hub
}

# =============================================================================
# Hub Peering Outputs (dev-glb specific)
# =============================================================================

output "hub_peerings" {
  description = "Hub-to-hub peering details"
  value = {
    weu_to_gwc = {
      id   = module.hub_weu_to_hub_gwc.id
      name = module.hub_weu_to_hub_gwc.name
    }
    gwc_to_weu = {
      id   = module.hub_gwc_to_hub_weu.id
      name = module.hub_gwc_to_hub_weu.name
    }
  }
}

output "hub_summary" {
  description = "Summary of all location hubs"
  value = {
    weu = {
      id   = local.hubs.weu.id
      name = local.hubs.weu.name
    }
    gwc = {
      id   = local.hubs.gwc.id
      name = local.hubs.gwc.name
    }
  }
}
