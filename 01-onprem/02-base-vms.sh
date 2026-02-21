#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

# Force line-buffered output so progress appears in real time
export ANSIBLE_FORCE_COLOR=1
export PYTHONUNBUFFERED=1

ansible-galaxy collection install -r 02-base-vms/requirements.yml

# Full run (provision + harden) — idempotent, safe to re-run
ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --diff --ask-become-pass


# to destroy
# ansible-playbook site.yml --tags destroy -e 'target_vms=["vm-base-dev-onprem-01"]' --ask-become-pass

# # Provision only
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags provision --diff --ask-become-pass

# # Provision specific VMs only
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags provision --diff --ask-become-pass \
#   -e 'target_vms=["vm-base-dev-onprem-01"]'

# # Harden only (VMs must already exist)
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags hardening --diff --ask-become-pass

# # Harden specific VMs only
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags hardening --diff --ask-become-pass \
#   --limit vm-base-dev-onprem-01

# # Individual hardening roles
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags ssh-hardening --diff --ask-become-pass
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags os-hardening --diff --ask-become-pass
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags fail2ban --diff --ask-become-pass

# # Dry run
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --check --diff --ask-become-pass

# # Destroy specific VMs
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags destroy --diff --ask-become-pass \
#   -e 'target_vms=["vm-base-dev-onprem-01"]'
