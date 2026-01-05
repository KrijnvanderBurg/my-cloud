# =============================================================================
# Import blocks for adopting existing bootstrap resources
# =============================================================================

import {
  id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  to = azurerm_resource_group.this
}

import {
  id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.storage_account_name}"
  to = azurerm_storage_account.this
}

import {
  for_each = toset(var.containers)
  id       = "https://${var.storage_account_name}.blob.core.windows.net/${each.value}"
  to       = azurerm_storage_container.this[each.key]
}

# =============================================================================
# Resource Group
# =============================================================================

resource "azurerm_resource_group" "this" {
  name     = "rg-tfstate-co-${var.environment}-${var.region}-01"
  location = var.location
  tags     = var.tags
}

# =============================================================================
# Storage Account for Terraform State
# =============================================================================

resource "azurerm_storage_account" "this" {
  name                = "sttfstateco${var.environment}${var.region}01"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"

  # Security hardening
  shared_access_key_enabled       = false
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true

  # Network restrictions
  #   network_rules {
  #     default_action = "Deny"
  #     bypass         = ["AzureServices"]
  #     ip_rules       = var.allowed_ips
  #   }

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

# =============================================================================
# Blob Properties (Versioning)
# =============================================================================

resource "azurerm_storage_account_blob_properties" "this" {
  storage_account_id = azurerm_storage_account.this.id

  versioning_enabled = var.enable_versioning

  delete_retention_policy {
    days = 30
  }

  container_delete_retention_policy {
    days = 30
  }
}

# =============================================================================
# Storage Containers
# =============================================================================

resource "azurerm_storage_container" "this" {
  for_each = toset(var.containers)

  name                  = each.value
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
