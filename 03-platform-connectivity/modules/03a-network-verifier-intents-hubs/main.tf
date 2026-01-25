# =============================================================================
# Network Verifier Intents - Hub to Hub
# =============================================================================
# Standard intent package for hub-to-hub reachability testing.
# Creates bidirectional intents between two hub VNets.
# =============================================================================

resource "azurerm_network_manager_verifier_workspace_reachability_analysis_intent" "hub_a_to_hub_b" {
  name                  = "intent-${var.hub_a.name}-to-${var.hub_b.name}"
  verifier_workspace_id = var.verifier_workspace_id
  description           = "Verify ${var.hub_a.name} can reach ${var.hub_b.name}"

  source_resource_id      = var.hub_a.id
  destination_resource_id = var.hub_b.id

  ip_traffic {
    source_ips        = var.hub_a.address_space
    source_ports      = ["*"]
    destination_ips   = var.hub_b.address_space
    destination_ports = var.destination_ports
    protocols         = var.protocols
  }
}

resource "azurerm_network_manager_verifier_workspace_reachability_analysis_intent" "hub_b_to_hub_a" {
  name                  = "intent-${var.hub_b.name}-to-${var.hub_a.name}"
  verifier_workspace_id = var.verifier_workspace_id
  description           = "Verify ${var.hub_b.name} can reach ${var.hub_a.name}"

  source_resource_id      = var.hub_b.id
  destination_resource_id = var.hub_a.id

  ip_traffic {
    source_ips        = var.hub_b.address_space
    source_ports      = ["*"]
    destination_ips   = var.hub_a.address_space
    destination_ports = var.destination_ports
    protocols         = var.protocols
  }
}
