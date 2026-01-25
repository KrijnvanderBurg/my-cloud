# =============================================================================
# Network Verifier Module
# =============================================================================
# Creates Azure Network Manager with Verifier Workspace.
# Use submodules (03a, 03b, etc.) to add standard intent packages.
# =============================================================================

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# -----------------------------------------------------------------------------
# Network Manager
# -----------------------------------------------------------------------------

resource "azurerm_network_manager" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  scope {
    subscription_ids = var.scope_subscription_ids
  }

  scope_accesses = ["Connectivity"]

  tags = var.tags
}

# -----------------------------------------------------------------------------
# Verifier Workspace
# -----------------------------------------------------------------------------

resource "azurerm_network_manager_verifier_workspace" "this" {
  name               = var.verifier_workspace_name
  network_manager_id = azurerm_network_manager.this.id
  location           = var.location
  description        = "Verifier workspace for reachability testing"

  tags = var.tags
}
