# =============================================================================
# Environment outputs
# =============================================================================
# Forward the baseline stack outputs.

# =============================================================================
# Project Outputs
# =============================================================================

output "project" {
  description = "OVHcloud Public Cloud project used by this environment"
  value       = module.baseline.project
}
