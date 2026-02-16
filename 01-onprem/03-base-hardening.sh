#!/bin/bash
set -euo pipefail

# Install required Ansible collections
ansible-galaxy collection install -r 03-base-hardening/requirements.yml

# Run hardening playbook
ansible-playbook -v 03-base-hardening/site.yml -i 03-base-hardening/inventories/dev --diff --ask-become-pass

# Optional: Run specific roles with tags
# ansible-playbook -v 03-base-hardening/site.yml -i 03-base-hardening/inventories/dev --tags admin-user --diff --ask-become-pass
# ansible-playbook -v 03-base-hardening/site.yml -i 03-base-hardening/inventories/dev --tags ssh-hardening --diff --ask-become-pass
# ansible-playbook -v 03-base-hardening/site.yml -i 03-base-hardening/inventories/dev --tags os-hardening --diff --ask-become-pass

# Dry run (check mode)
# ansible-playbook -v 03-base-hardening/site.yml -i 03-base-hardening/inventories/dev --check --diff --ask-become-pass
