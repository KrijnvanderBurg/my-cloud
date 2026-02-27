# =============================================================================
# Base VM Module
# =============================================================================
# Creates a single KVM virtual machine with cloud-init configuration,
# per-VM SSH keypair, and static networking.
# =============================================================================

terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

# =============================================================================
# SSH Keypair
# =============================================================================

resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "private_key" {
  filename        = "${var.vm_keys_dir}/${var.name}_id_ed25519"
  content         = tls_private_key.this.private_key_openssh
  file_permission = "0600"
}

resource "local_file" "public_key" {
  filename        = "${var.vm_keys_dir}/${var.name}_id_ed25519.pub"
  content         = tls_private_key.this.public_key_openssh
  file_permission = "0644"
}

# =============================================================================
# VM Disk (COW overlay from base image)
# =============================================================================

resource "libvirt_volume" "this" {
  name             = "${var.name}.qcow2"
  pool             = var.pool_name
  base_volume_id   = var.base_volume_id
  size             = var.disk_gb * 1073741824 # GB to bytes
  format           = "qcow2"
}

# =============================================================================
# Cloud-Init
# =============================================================================

resource "libvirt_cloudinit_disk" "this" {
  name = "${var.name}-cloudinit.iso"
  pool = var.pool_name

  user_data = templatefile("${path.module}/templates/user-data.yml.tftpl", {
    hostname   = var.name
    admin_user = var.admin_user
    groups     = join(",", var.admin_groups)
    ssh_pubkey = trimspace(tls_private_key.this.public_key_openssh)
  })

  meta_data = templatefile("${path.module}/templates/meta-data.yml.tftpl", {
    instance_id    = var.name
    local_hostname = var.name
  })

  network_config = templatefile("${path.module}/templates/network-config.yml.tftpl", {
    address = var.ip_address
    gateway = var.gateway
    dns     = var.dns
  })
}

# =============================================================================
# VM Domain
# =============================================================================

resource "libvirt_domain" "this" {
  name      = var.name
  memory    = var.memory_mb
  vcpu      = var.vcpus
  autostart = true
  cloudinit = libvirt_cloudinit_disk.this.id

  disk {
    volume_id = libvirt_volume.this.id
  }

  network_interface {
    network_name   = var.network_name
    addresses      = [var.ip_address]
    wait_for_lease = false
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "vnc"
    listen_type = "none"
  }
}
