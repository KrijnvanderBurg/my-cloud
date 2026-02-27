#!/bin/bash
set -e

echo "Installing Ansible Galaxy requirements..."

ansible-galaxy collection install -r requirements.yml --force
ansible-galaxy role install -r requirements.yml --force 2>/dev/null || true
echo "Galaxy requirements installed successfully."
