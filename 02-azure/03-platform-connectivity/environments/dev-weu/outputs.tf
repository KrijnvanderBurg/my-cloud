# =============================================================================
# Hub Network Outputs
# =============================================================================

output "hub" {
  description = "Hub VNet details"
  value       = module.baseline.hub
}

output "spokes" {
  description = "Spoke VNet details"
  value = {
    plz_drives = {
      cidr = local.plz_drives_cidr
    }
  }
}
