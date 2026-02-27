# =============================================================================
# Dev Environment - Base VMs
# =============================================================================

# =============================================================================
# Base Cloud Image (shared across all VMs)
# =============================================================================

resource "libvirt_volume" "base_image" {
  name   = local.cloud_image_name
  pool   = local.libvirt_pool
  source = local.cloud_image_url
  format = "qcow2"
}

# =============================================================================
# SSH Keys Directory
# =============================================================================

resource "null_resource" "vm_keys_dir" {
  provisioner "local-exec" {
    command = "mkdir -p '${local.vm_keys_dir}' && chmod 700 '${local.vm_keys_dir}'"
  }
}

# =============================================================================
# VM Instances
# =============================================================================

module "vm" {
  source   = "../../modules/01-base-vm"
  for_each = local.vms

  name           = each.key
  vcpus          = lookup(each.value, "vcpus", local.vm_types[each.value.type].vcpus)
  memory_mb      = lookup(each.value, "memory_mb", local.vm_types[each.value.type].memory_mb)
  disk_gb        = lookup(each.value, "disk_gb", local.vm_types[each.value.type].disk_gb)
  admin_user     = local.admin_user
  admin_groups   = local.admin_groups
  vm_keys_dir    = local.vm_keys_dir
  base_volume_id = libvirt_volume.base_image.id
  pool_name      = local.libvirt_pool
  network_name   = local.libvirt_network

  depends_on = [null_resource.vm_keys_dir]
}
