# Ansible for pfSense NVA Configuration

This directory contains Ansible playbooks for configuring the pfSense HA NVA pair.

## Prerequisites

1. Deploy hub infrastructure via Terraform first
2. Ensure jumpbox is accessible for SSH proxy
3. pfSense VMs are running and accessible

## Dynamic Inventory

The inventory is generated dynamically from Terraform outputs:

```bash
# Test inventory generation
./inventory/terraform_inventory.py --list

# Run with dynamic inventory
ansible-inventory -i inventory/terraform_inventory.py --list
```

## Usage

```bash
# Configure pfSense HA pair (via jumpbox proxy)
ansible-playbook -i inventory/terraform_inventory.py playbooks/pfsense-ha.yml \
  --ssh-extra-args="-o ProxyJump=jmpadmin@<jumpbox-ip>"

# Dry run
ansible-playbook -i inventory/terraform_inventory.py playbooks/pfsense-ha.yml --check
```

## Playbooks

| Playbook | Description |
|----------|-------------|
| `pfsense-ha.yml` | Configure CARP HA, firewall rules, NAT |

## Variables

Sensitive variables should be stored in Ansible Vault:

```bash
ansible-vault create group_vars/all/vault.yml
```

Required vault variables:
- `vault_carp_password` - CARP shared secret
