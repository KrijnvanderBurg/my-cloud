# =============================================================================
# Network Verifier Intents - Hub to Hub - Outputs
# =============================================================================

output "intent_ids" {
  description = "IDs of the created intents"
  value = {
    hub_a_to_hub_b = azurerm_network_manager_verifier_workspace_reachability_analysis_intent.hub_a_to_hub_b.id
    hub_b_to_hub_a = azurerm_network_manager_verifier_workspace_reachability_analysis_intent.hub_b_to_hub_a.id
  }
}

output "intent_names" {
  description = "Names of the created intents"
  value = [
    azurerm_network_manager_verifier_workspace_reachability_analysis_intent.hub_a_to_hub_b.name,
    azurerm_network_manager_verifier_workspace_reachability_analysis_intent.hub_b_to_hub_a.name
  ]
}
