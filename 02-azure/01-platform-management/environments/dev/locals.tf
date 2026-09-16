locals {
  tenant_id   = "90d27970-b92c-43dc-9935-1ed557d8e20e"
  environment = "dev"
  common_tags = {
    environment = local.environment
    managed_by  = "opentofu"
    project     = "levendaal"
    layer       = "platform-management"
    owner       = "kvdb"
    cost_center = "platform"
  }

  # Subscriptions (per-environment)
  platform_management_subscription_id   = "e388ddce-c79d-4db0-8a6f-cd69b1708954"
  platform_identity_subscription_id     = "9312c5c5-b089-4b62-bb90-0d92d421d66c"
  platform_connectivity_subscription_id = "6018b0fb-7b8c-491f-8abf-375d2c07ef97"
  plz_drives_subscription_id            = "9af01e5c-f933-4b86-a389-a8ac837965a5"
  alz_drive_subscription_id             = "4111975b-f6ca-4e08-b7b6-87d7b6c35840"

  # Terraform state storage (per-environment)
  tfstate_storage_account_name                = "sttfstatecodevgwc01"
  tfstate_storage_account_resource_group_name = "rg-tfstate-co-dev-gwc-01"
  tfstate_subscription_id                     = local.platform_management_subscription_id
}
