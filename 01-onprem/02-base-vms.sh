#!/bin/bash
set -euo pipefail

ansible-galaxy collection install -v -r 02-base-vms/requirements.yml

# Full run (provision + harden) — idempotent, safe to re-run
ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --diff --ask-become-pass

# # Provision only (skip hardening)
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags provision --diff --ask-become-pass

# # Harden only (VMs must already exist)
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags hardening --diff --ask-become-pass

# # Individual hardening roles
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags admin-user --diff --ask-become-pass
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags ssh-hardening --diff --ask-become-pass
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags os-hardening --diff --ask-become-pass
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags fail2ban --diff --ask-become-pass

# # Dry run
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --check --diff --ask-become-pass

# # Full reset — destroy all VMs and start fresh (uncomment and run manually)
# vms=$(virsh list --all --name | sed '/^$/d')
# for vm in $vms; do
#   echo "Destroying and undefining: $vm"
#   sudo virsh destroy "$vm" 2>/dev/null || true
#   sudo virsh undefine "$vm" --remove-all-storage 2>/dev/null || sudo virsh undefine "$vm" || true
#   sudo rm -f "/var/lib/libvirt/images/${vm}.qcow2.customized"
#   sudo rm -f "/var/lib/libvirt/images/${vm}-network-config.yml"
# done
