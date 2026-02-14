#!/bin/bash
set -e

echo "Installing Ansible and ansible-lint..."
pip install --quiet ansible ansible-lint
echo "Ansible version: $(ansible --version | head -1)"
