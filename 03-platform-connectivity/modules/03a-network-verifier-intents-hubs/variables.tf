# =============================================================================
# Network Verifier Intents - Hub to Hub
# =============================================================================
# Standard intent package for hub-to-hub reachability testing.
# Creates bidirectional intents between two hub VNets.
# =============================================================================

variable "verifier_workspace_id" {
  description = "ID of the Verifier Workspace to create intents in"
  type        = string
}

variable "hub_a" {
  description = "First hub VNet details"
  type = object({
    name          = string
    id            = string
    address_space = list(string)
  })
}

variable "hub_b" {
  description = "Second hub VNet details"
  type = object({
    name          = string
    id            = string
    address_space = list(string)
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
