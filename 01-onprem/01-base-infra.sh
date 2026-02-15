# Full run (provision + harden)
ansible-playbook -v 01-base-infra/site.yml -i 01-base-infra/inventories/dev --diff --ask-become-pass

# # Provision only
# ansible-playbook -v 01-base-infra/site.yml -i 01-base-infra/inventories/dev --tags provision

# # Harden only (VMs must exist)
# ansible-playbook -v 01-base-infra/site.yml -i 01-base-infra/inventories/dev --tags hardening

# # Dry run
# ansible-playbook -v 01-base-infra/site.yml -i 01-base-infra/inventories/dev --check --diff
