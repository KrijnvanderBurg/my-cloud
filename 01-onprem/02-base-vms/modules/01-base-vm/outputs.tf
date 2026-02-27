# =============================================================================
# Base VM Module - Outputs
# =============================================================================

output "name" {
  description = "VM name"
  value       = libvirt_domain.this.name
}

output "id" {
  description = "Libvirt domain ID"
  value       = libvirt_domain.this.id
}

output "ip_address" {
  description = "DHCP-assigned IP address of the VM"
  value       = libvirt_domain.this.network_interface[0].addresses[0]
}

output "ssh_private_key_path" {
  description = "Path to the VM's private SSH key"
  value       = local_sensitive_file.private_key.filename
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i ${local_sensitive_file.private_key.filename} ${var.admin_user}@${libvirt_domain.this.network_interface[0].addresses[0]}"
}
