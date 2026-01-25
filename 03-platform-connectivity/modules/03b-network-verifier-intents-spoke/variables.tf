# =============================================================================
# Network Verifier Intents - Spoke to Hub
# =============================================================================
# Standard intent package for spoke-to-hub reachability testing.
# Creates intent from spoke subnet to hub shared services subnet.
# =============================================================================

variable "verifier_workspace_id" {
  description = "ID of the Verifier Workspace to create intents in"
  type        = string
}

variable "spoke_subnet" {
  description = "Spoke subnet details"
  type = object({
    id             = string
    name           = string
    address_prefix = string
  })
}

variable "hub_subnet" {
  description = "Hub subnet details"
  type = object({
    id               = string
    name             = string
    address_prefixes = list(string)
  })
}

variable "destination_ports" {
  description = "Destination ports to test"
  type        = list(string)
  default     = ["443"]
}

variable "protocols" {
  description = "Protocols to test"
  type        = list(string)
  default     = ["TCP"]
}
