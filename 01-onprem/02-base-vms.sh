#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

# Full run
tofu -chdir=02-base-vms/environments/dev init
tofu -chdir=02-base-vms/environments/dev apply

# # Plan only (dry run)
# tofu -chdir=02-base-vms/environments/dev plan

# # Destroy all VMs
# tofu -chdir=02-base-vms/environments/dev destroy
