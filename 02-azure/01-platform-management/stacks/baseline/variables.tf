# =============================================================================
# Baseline stack contract
# =============================================================================
# Required inputs (no defaults) act as the per-environment contract: an
# environment root that forgets to supply one of these fails at plan time.

variable "environment" {
  description = "Environment name used in resource naming (e.g. dev, test, prod)"
  type        = string
}

variable "tenant_id" {
  description = "The Azure AD tenant ID; also the name of the tenant root management group"
  type        = string
}

variable "platform_management_subscription_id" {
  description = "Subscription ID for the Platform Management subscription"
  type        = string
}

variable "platform_identity_subscription_id" {
  description = "Subscription ID for the Platform Identity subscription"
  type        = string
}

variable "platform_connectivity_subscription_id" {
  description = "Subscription ID for the Platform Connectivity subscription"
  type        = string
}

variable "plz_drives_subscription_id" {
  description = "Subscription ID for the Platform Landing Zone Drives subscription"
  type        = string
}

variable "tfstate_storage_account_name" {
  description = "Name of the Terraform state storage account for this environment"
  type        = string
}

variable "tfstate_storage_account_resource_group_name" {
  description = "Resource group of the Terraform state storage account for this environment"
  type        = string
}

variable "tfstate_subscription_id" {
  description = "Subscription ID where the Terraform state storage account lives"
  type        = string
}
