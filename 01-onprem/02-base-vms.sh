#!/bin/bash
set -euo pipefail

vms=$(virsh list --all --name | sed '/^$/d')
for vm in $vms; do
  echo "Destroying and undefining: $vm"
  sudo virsh destroy "$vm" 2>/dev/null || true
  sudo virsh undefine "$vm" --remove-all-storage 2>/dev/null || sudo virsh undefine "$vm" || true
done

ansible-galaxy collection install -v -r 02-base-vms/requirements.yml

# Full run (provision + harden)
ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --diff --ask-become-pass


# # Provision only
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags provision --diff --ask-become-pass

# # Harden only (VMs must exist)
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags hardening --diff --ask-become-pass

# # Dry run
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --check --diff --ask-become-pass
