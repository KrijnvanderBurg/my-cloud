# =============================================================================
# Dev Environment - Local Variables
# =============================================================================

locals {
  # ---------------------------------------------------------------------------
  # Metadata
  # ---------------------------------------------------------------------------
  env        = "dev"
  project    = "levendaal"
  managed_by = "opentofu"
  layer      = "base-vms"

  # ---------------------------------------------------------------------------
  # User / SSH
  # ---------------------------------------------------------------------------
  actual_user = "x0r"
  vm_keys_dir = "/home/${local.actual_user}/.ssh/vm-keys-${local.env}"

  # ---------------------------------------------------------------------------
  # Cloud Image
  # ---------------------------------------------------------------------------
  cloud_image_url  = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  cloud_image_name = "noble-server-cloudimg-amd64.img"

  # ---------------------------------------------------------------------------
  # Libvirt
  # ---------------------------------------------------------------------------
  libvirt_pool    = "default"
  libvirt_network = "default"

  # ---------------------------------------------------------------------------
  # Network
  # ---------------------------------------------------------------------------
  network_gateway = "192.168.122.1"
  network_dns     = "192.168.122.1"

  # ---------------------------------------------------------------------------
  # Admin User (created by cloud-init)
  # ---------------------------------------------------------------------------
  admin_user   = "ansible"
  admin_groups = ["sudo"]

  # ---------------------------------------------------------------------------
  # VM Types — reusable profiles
  # ---------------------------------------------------------------------------
  vm_types = {
    small = {
      vcpus     = 2
      memory_mb = 2048
      disk_gb   = 20
    }
    medium = {
      vcpus     = 4
      memory_mb = 4096
      disk_gb   = 40
    }
    large = {
      vcpus     = 8
      memory_mb = 8192
      disk_gb   = 80
    }
  }

  # ---------------------------------------------------------------------------
  # VM Fleet — single source of truth for infrastructure
  # ---------------------------------------------------------------------------
  # Add/remove VMs here, then run: tofu apply
  #
  # Each entry supports optional per-VM overrides for vcpus, memory_mb, disk_gb.
  # If omitted, values are inherited from the vm_type.
  # ---------------------------------------------------------------------------
  vms = {
    vm-base-dev-onprem-01 = {
      ip_address = "192.168.122.101"
      type       = "small"
    }
    vm-base-dev-onprem-02 = {
      ip_address = "192.168.122.102"
      type       = "small"
    }
  }
}
