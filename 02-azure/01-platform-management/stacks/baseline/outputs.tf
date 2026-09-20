# =============================================================================
# Tenant Outputs
# =============================================================================

output "tenant_id" {
  description = "The Azure AD tenant ID"
  value       = var.tenant_id
}

output "tenant_root_management_group_id" {
  description = "The fully qualified ID of the tenant root management group"
  value       = data.azurerm_management_group.tenant_root.id
}

# =============================================================================
# Management Group Outputs
# =============================================================================

output "levendaal_management_group" {
  description = "KrijnvanderBurg root management group details"
  value = {
    id           = module.krijnvanderburg.id
    name         = module.krijnvanderburg.name
    display_name = module.krijnvanderburg.display_name
  }
}

output "sandbox_management_group" {
  description = "Sandbox management group details"
  value = {
    id           = module.sandbox.id
    name         = module.sandbox.name
    display_name = module.sandbox.display_name
  }
}

output "platform_management_group" {
  description = "Platform management group details"
  value = {
    id           = module.platform.id
    name         = module.platform.name
    display_name = module.platform.display_name
  }
}

output "landingzone_management_group" {
  description = "Landing Zone management group details"
  value = {
    id           = module.landingzone.id
    name         = module.landingzone.name
    display_name = module.landingzone.display_name
  }
}

# =============================================================================
# Subscription Outputs
# =============================================================================

output "pl_management_subscription" {
  description = "Platform Management subscription"
  value = {
    id              = data.azurerm_subscription.platform_management.id
    subscription_id = data.azurerm_subscription.platform_management.subscription_id
  }
}

output "pl_identity_subscription" {
  description = "Platform Identity subscription"
  value = {
    id              = data.azurerm_subscription.platform_identity.id
    subscription_id = data.azurerm_subscription.platform_identity.subscription_id
  }
}

output "pl_connectivity_subscription" {
  description = "Platform Connectivity subscription"
  value = {
    id              = data.azurerm_subscription.platform_connectivity.id
    subscription_id = data.azurerm_subscription.platform_connectivity.subscription_id
  }
}

output "plz_drives_subscription" {
  description = "Platform Landing Zone Drives subscription"
  value = {
    id              = data.azurerm_subscription.plz_drives.id
    subscription_id = data.azurerm_subscription.plz_drives.subscription_id
  }
}

# =============================================================================
# Environment Information
# =============================================================================

output "environment" {
  description = "The current environment name"
  value       = var.environment
}

# =============================================================================
# Terraform State Storage
# =============================================================================

output "tfstate_storage_account" {
  description = "Terraform state storage account details"
  value = {
    id                  = "/subscriptions/${var.tfstate_subscription_id}/resourceGroups/${var.tfstate_storage_account_resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.tfstate_storage_account_name}"
    name                = var.tfstate_storage_account_name
    resource_group_name = var.tfstate_storage_account_resource_group_name
    subscription_id     = var.tfstate_subscription_id
  }
}

output "tfstate_subscription" {
  description = "Subscription where tfstate storage account is located"
  value = {
    id              = "/subscriptions/${var.tfstate_subscription_id}"
    subscription_id = var.tfstate_subscription_id
  }
}
