# =============================================================================
# Baseline stack
# =============================================================================
# All resources that must exist in every environment.

module "baseline" {
  source = "../../stacks/baseline"

  project_id  = local.project_id
  environment = local.environment
  common_tags = local.common_tags
}

# =============================================================================
# Environment-only extras (dev)
# =============================================================================
# Add resources that should exist ONLY in this environment here as explicit
# module blocks. Nothing environment-specific is hidden behind conditionals.
