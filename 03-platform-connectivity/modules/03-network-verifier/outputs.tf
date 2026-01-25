# =============================================================================
# Network Verifier Module - Outputs
# =============================================================================

output "network_manager_id" {
  description = "ID of the Network Manager"
  value       = azurerm_network_manager.this.id
}

output "network_manager_name" {
  description = "Name of the Network Manager"
  value       = azurerm_network_manager.this.name
}

output "verifier_workspace_id" {
  description = "ID of the Verifier Workspace"
  value       = azurerm_network_manager_verifier_workspace.this.id
}

output "verifier_workspace_name" {
  description = "Name of the Verifier Workspace"
  value       = azurerm_network_manager_verifier_workspace.this.name
}
