#!/bin/bash
target_path="${1:-$PWD/infrastructure}" && echo "Initializing OpenTofu in: $target_path"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1
tofu init
