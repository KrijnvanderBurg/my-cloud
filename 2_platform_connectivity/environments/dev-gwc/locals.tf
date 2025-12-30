# -----------------------------------------------------------------------------
# Locals - Germany West Central Hub
# -----------------------------------------------------------------------------

locals {
  pr_suffix   = var.pr_number != "" ? "-pr${var.pr_number}" : ""
  environment = var.environment

  common_tags = merge(var.tags, {
    environment = var.environment
    region      = var.location_short
    managed_by  = "opentofu"
    project     = "levendaal"
    pr_number   = var.pr_number
  })

  # Naming convention: <type>-<workload>-<archetype>-<env>-<region>-<instance><pr_suffix>
  # Hub resources
  hub_rg_name   = "rg-hub-co-${var.environment}-${var.location_short}-01${local.pr_suffix}"
  hub_vnet_name = "vnet-hub-co-${var.environment}-${var.location_short}-01${local.pr_suffix}"

  # Identity spoke resources
  identity_rg_name   = "rg-identity-co-${var.environment}-${var.location_short}-01${local.pr_suffix}"
  identity_vnet_name = "vnet-identity-co-${var.environment}-${var.location_short}-01${local.pr_suffix}"

  # Management spoke resources
  management_rg_name   = "rg-management-co-${var.environment}-${var.location_short}-01${local.pr_suffix}"
  management_vnet_name = "vnet-management-co-${var.environment}-${var.location_short}-01${local.pr_suffix}"
}
