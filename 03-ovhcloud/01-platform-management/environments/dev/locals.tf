locals {
  project_id  = "f350cf3e972b41fca80eb0a0a1b69dbf"
  environment = "dev"
  common_tags = {
    environment = local.environment
    managed_by  = "opentofu"
    project     = "levendaal"
    layer       = "platform-management"
    owner       = "kvdb"
    cost_center = "platform"
  }
}
