#!/bin/bash
set -euo pipefail

# Full run (provision + harden)
ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --diff --ask-become-pass

# # Provision only
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags provision --diff --ask-become-pass

# # Harden only (VMs must exist)
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --tags hardening --diff --ask-become-pass

# # Dry run
# ansible-playbook -v 02-base-vms/site.yml -i 02-base-vms/inventories/dev --check --diff --ask-become-pass
