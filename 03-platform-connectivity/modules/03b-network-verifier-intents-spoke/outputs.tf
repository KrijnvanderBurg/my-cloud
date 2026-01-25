# =============================================================================
# Network Verifier Intents - Spoke to Hub - Outputs
# =============================================================================

output "intent_id" {
  description = "ID of the created intent"
  value       = azurerm_network_manager_verifier_workspace_reachability_analysis_intent.spoke_to_hub.id
}

output "intent_name" {
  description = "Name of the created intent"
  value       = azurerm_network_manager_verifier_workspace_reachability_analysis_intent.spoke_to_hub.name
}
