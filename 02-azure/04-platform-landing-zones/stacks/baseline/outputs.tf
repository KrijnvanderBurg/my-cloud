# =============================================================================
# Landing Zone Outputs
# =============================================================================

output "landing_zone" {
  description = "Landing zone details"
  value = {
    id = module.landing_zone.id
  }
}
