# -----------------------------------------------------------------------------
# NAT Gateway Module - Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "Name of the NAT gateway"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP for NAT gateway"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the NAT gateway"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the NAT gateway"
  type        = map(string)
}
