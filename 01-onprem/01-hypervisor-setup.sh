#!/bin/bash
set -euo pipefail

# Full run
ansible-galaxy collection install
ansible-playbook -v 01-hypervisor-setup/site.yml -i 01-hypervisor-setup/inventories/dev --diff --ask-become-pass

# # Dry run
# ansible-playbook -v 01-hypervisor-setup/site.yml -i 01-hypervisor-setup/inventories/dev --check --diff --ask-become-pass
