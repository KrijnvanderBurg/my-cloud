# Agent Instructions

## Documentation
- [README](../README.md) - Project overview, deployment history, and setup
- [Naming Convention](naming-convention.md) - Azure and on-prem resource naming standards

## Structure
- `01-onprem/` — On-premises infrastructure managed with Ansible
  - `01-hypervisor-setup/` — KVM/libvirt hypervisor configuration and SSH keypair generation
  - `02-base-vms/` — VM provisioning (virt-customize + virt-install) and hardening (admin user, SSH, OS, firewall)
  - Each numbered directory is an independent Ansible project (layer)
  - One `site.yml` per layer, inventories per environment under `inventories/`
  - Roles under `roles/` follow standard Ansible role structure
  - CI/CD via `.github/workflows/ansible-deployment-all.yml`
  - Deployment chain: `op-hypervisor-setup-dev` → `op-base-vms-dev` → `op-openclaw-dev`
- `02-azure/` — Azure Landing Zone managed with OpenTofu
  - Environments under `environments/`, modules under `modules/`
