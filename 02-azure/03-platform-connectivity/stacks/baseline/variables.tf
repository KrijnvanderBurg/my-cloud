# =============================================================================
# Baseline stack contract
# =============================================================================
# Required inputs (no defaults) act as the per-environment contract.

variable "environment" {
  description = "Environment name (e.g. dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure location for resources"
  type        = string
}

variable "location_short" {
  description = "Short location code for naming (e.g. gwc, weu)"
  type        = string
}

variable "hub_cidr" {
  description = "CIDR block for the hub network"
  type        = string
}

variable "hub_azure_subnets" {
  description = "Azure-reserved subnets for the hub"
  type        = map(string)
}

variable "hub_managed_subnets" {
  description = "Platform-managed subnets for the hub"
  type        = map(string)
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}
