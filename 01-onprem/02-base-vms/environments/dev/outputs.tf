# =============================================================================
# Dev Environment - Outputs
# =============================================================================

output "vms" {
  description = "Map of VM name to connection details"
  value = {
    for name, vm in module.vm : name => {
      ip_address = vm.ip_address
      ssh_command = vm.ssh_command
    }
  }
}
