output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint URL"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_names" {
  description = "List of created container names"
  value       = [for c in azurerm_storage_container.this : c.name]
}
