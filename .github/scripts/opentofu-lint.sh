#!/bin/bash
target_path="${1:-$PWD/infrastructure}" && echo "Linting OpenTofu files in: $target_path"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1
echo "Checking formatting..." && tofu fmt -check -recursive
echo "Validating configuration..." && tofu validate
