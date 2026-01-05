variable "environment" {
  description = "Environment name (e.g., dev, prd)"
  type        = string
}

variable "region" {
  description = "Short region code (e.g., gwc, weu)"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "allowed_ips" {
  description = "List of IP addresses/CIDR ranges allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "containers" {
  description = "List of blob container names to create for state files"
  type        = list(string)
  default     = []
}

variable "enable_versioning" {
  description = "Enable blob versioning for state file protection"
  type        = bool
  default     = true
}

variable "subscription_id" {
  description = "Azure subscription ID where resources exist"
  type        = string
}

variable "resource_group_name" {
  description = "Name of existing resource group to import"
  type        = string
}

variable "storage_account_name" {
  description = "Name of existing storage account to import"
  type        = string
}
