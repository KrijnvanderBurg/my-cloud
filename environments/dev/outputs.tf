output "tenant_root_management_group_id" {
  description = "The ID of the tenant root management group"
  value       = data.azurerm_management_group.tenant_root.id
}

output "platform_management_group_id" {
  description = "The ID of the platform management group"
  value       = module.platform_management_group.id
}

output "sandbox_management_group_id" {
  description = "The ID of the sandbox management group"
  value       = module.sandbox_management_group.id
}
