#!/bin/bash
target_path="${1:-$PWD/infrastructure}" && echo "Planning OpenTofu changes in: $target_path"
var_file="${2:-}" && [[ -n "$var_file" ]] && echo "Using variables file: $var_file"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1
tofu plan ${var_file:+-var-file="$var_file"}
