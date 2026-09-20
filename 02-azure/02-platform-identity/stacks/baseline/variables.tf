# =============================================================================
# Baseline stack contract
# =============================================================================
# Required inputs (no defaults) act as the per-environment contract: an
# environment root that forgets to supply one of these fails at plan time.
# Management-layer values are passed in explicitly so this stack stays pure
# and does not read remote state itself.

variable "environment" {
  description = "Environment name used in resource naming (e.g. dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure location for regional resources (e.g. germanywestcentral)"
  type        = string
}

variable "location_short" {
  description = "Short location code used in naming (e.g. gwc)"
  type        = string
}

variable "alert_email" {
  description = "Email address that receives identity security alerts"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources that support tagging"
  type        = map(string)
}

# --- Values sourced from the platform-management layer ---

variable "pl_connectivity_subscription_scope" {
  description = "Full resource ID scope of the Platform Connectivity subscription"
  type        = string
}

variable "plz_drives_subscription_scope" {
  description = "Full resource ID scope of the Platform Landing Zone Drives subscription"
  type        = string
}

variable "pl_identity_subscription_id" {
  description = "Subscription ID (UUID) of the Platform Identity subscription to monitor"
  type        = string
}

variable "tfstate_storage_account_id" {
  description = "Resource ID of the Terraform state storage account"
  type        = string
}
