# =============================================================================
# Baseline stack contract
# =============================================================================
# Required inputs (no defaults) act as the per-environment contract.

variable "landing_zone" {
  description = "Landing zone name (e.g. drives, aks)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure location for resources"
  type        = string
}

variable "location_short" {
  description = "Short location code for naming (e.g. weu, gwc)"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "spoke_cidr" {
  description = "CIDR block for the spoke network"
  type        = string
}

variable "hub_vnet_id" {
  description = "Resource ID of the hub VNet for peering"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub VNet"
  type        = string
}

variable "hub_resource_group_name" {
  description = "Resource group name where hub VNet resides"
  type        = string
}

variable "lz_managed_subnets" {
  description = "Landing zone managed subnets configuration"
  type        = map(any)
}

variable "azure_reserved_subnets" {
  description = "Azure reserved subnets configuration"
  type        = map(any)
}

variable "azure_delegated_subnets" {
  description = "Azure delegated subnets configuration"
  type        = map(any)
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}
