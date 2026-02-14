# Agent Instructions

## Documentation
- [README](../README.md) - Project overview, deployment history, and setup
- [Naming Convention](naming-convention.md) - Azure and on-prem resource naming standards

## Structure
- `01-onprem/` — On-premises infrastructure managed with Ansible
  - Each numbered directory is an independent Ansible project (layer)
  - One `site.yml` per layer, inventories per environment under `inventories/`
  - Roles under `roles/` follow standard Ansible role structure
  - CI/CD via `.github/workflows/ansible-deployment-all.yml`
- `02-azure/` — Azure Landing Zone managed with OpenTofu
  - Each numbered directory is an independent OpenTofu deployment (layer)
  - Environments under `environments/`, modules under `modules/`
  - CI/CD via `.github/workflows/opentofu-deployment-all.yml`
