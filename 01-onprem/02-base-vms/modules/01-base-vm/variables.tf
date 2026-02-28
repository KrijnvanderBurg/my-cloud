# =============================================================================
# Base VM Module - Variables
# =============================================================================

variable "name" {
  description = "VM name (used for hostname, disk, domain)"
  type        = string
}

variable "vcpus" {
  description = "Number of virtual CPUs"
  type        = number
  default     = 2
}

variable "memory_mb" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "disk_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "admin_user" {
  description = "Administrative user created by cloud-init"
  type        = string
  default     = "ansible"
}

variable "admin_groups" {
  description = "Groups for the admin user"
  type        = list(string)
  default     = ["sudo"]
}

variable "vm_keys_dir" {
  description = "Directory to write SSH keypairs to"
  type        = string
}

variable "base_volume_id" {
  description = "ID of the base cloud image volume"
  type        = string
}

variable "pool_name" {
  description = "Libvirt storage pool name"
  type        = string
  default     = "default"
}

variable "network_name" {
  description = "Libvirt network name"
  type        = string
  default     = "default"
}

variable "ip_address" {
  description = "Static IP address for the VM"
  type        = string
}

variable "gateway" {
  description = "Default gateway IP"
  type        = string
}

variable "dns" {
  description = "List of DNS server IPs"
  type        = list(string)
}

variable "prefix_length" {
  description = "Network prefix length (e.g. 24 for /24)"
  type        = number
  default     = 24
}
