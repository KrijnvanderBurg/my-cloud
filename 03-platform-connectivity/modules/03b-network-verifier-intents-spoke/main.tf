# =============================================================================
# Network Verifier Intents - Spoke to Hub
# =============================================================================
# Standard intent package for spoke-to-hub reachability testing.
# Creates intent from spoke subnet to hub shared services subnet.
# =============================================================================

resource "azurerm_network_manager_verifier_workspace_reachability_analysis_intent" "spoke_to_hub" {
  name                  = "intent-${var.spoke_subnet.name}-to-${var.hub_subnet.name}"
  verifier_workspace_id = var.verifier_workspace_id
  description           = "Verify ${var.spoke_subnet.name} can reach ${var.hub_subnet.name}"

  source_resource_id      = var.spoke_subnet.id
  destination_resource_id = var.hub_subnet.id

  ip_traffic {
    source_ips        = [var.spoke_subnet.address_prefix]
    source_ports      = ["*"]
    destination_ips   = var.hub_subnet.address_prefixes
    destination_ports = var.destination_ports
    protocols         = var.protocols
  }
}
