#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

# Force line-buffered output so progress appears in real time
export ANSIBLE_FORCE_COLOR=1
export PYTHONUNBUFFERED=1

ansible-galaxy collection install -r 03-base-vms-hardening/requirements.yml

# Full run — idempotent, safe to re-run
ansible-playbook -v 03-base-vms-hardening/site.yml -i 03-base-vms-hardening/inventories/dev --diff --ask-become-pass

# # Dry run
# ansible-playbook -v 03-base-vms-hardening/site.yml -i 03-base-vms-hardening/inventories/dev --check --diff --ask-become-pass

# # SSH hardening only
# ansible-playbook -v 03-base-vms-hardening/site.yml -i 03-base-vms-hardening/inventories/dev --tags ssh-hardening --diff --ask-become-pass

# # OS hardening only
# ansible-playbook -v 03-base-vms-hardening/site.yml -i 03-base-vms-hardening/inventories/dev --tags os-hardening --diff --ask-become-pass

# # Fail2ban only
# ansible-playbook -v 03-base-vms-hardening/site.yml -i 03-base-vms-hardening/inventories/dev --tags fail2ban --diff --ask-become-pass

# # Limit to specific VMs
# ansible-playbook -v 03-base-vms-hardening/site.yml -i 03-base-vms-hardening/inventories/dev --diff --ask-become-pass \
#   --limit vm-base-dev-onprem-01
