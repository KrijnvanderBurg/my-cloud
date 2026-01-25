# =============================================================================
# Network Verifier Module - Variables
# =============================================================================

variable "name" {
  description = "Name of the Network Manager"
  type        = string
}

variable "verifier_workspace_name" {
  description = "Name of the Verifier Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the Network Manager"
  type        = string
}

variable "scope_subscription_ids" {
  description = "List of subscription IDs in scope for the Network Manager"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
