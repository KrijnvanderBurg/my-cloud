#!/bin/bash
set -euo pipefail

# Full run
ansible-galaxy collection install -v -r 01-hypervisor-setup/requirements.yml
ansible-playbook -vv 01-hypervisor-setup/site.yml -i 01-hypervisor-setup/inventories/dev --diff --ask-become-pass

# # Dry run
# ansible-playbook -vv 01-hypervisor-setup/site.yml -i 01-hypervisor-setup/inventories/dev --check --diff --ask-become-pass
