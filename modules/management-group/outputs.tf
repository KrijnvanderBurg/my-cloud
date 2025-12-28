output "id" {
  description = "Management group ID"
  value       = azurerm_management_group.this.id
}

output "name" {
  description = "Management group name"
  value       = azurerm_management_group.this.name
}

output "display_name" {
  description = "Management group display name"
  value       = azurerm_management_group.this.display_name
}
