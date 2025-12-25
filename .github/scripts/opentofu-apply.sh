#!/bin/bash
target_path="${1:-$PWD/infrastructure}" && echo "Applying OpenTofu changes in: $target_path"
var_file="${2:-}" && [[ -n "$var_file" ]] && echo "Using variables file: $var_file"
auto_approve="${3:-false}"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1
tofu apply \
  ${auto_approve:+$([ "$auto_approve" = "true" ] && echo "-auto-approve")} \
  ${var_file:+-var-file="$var_file"}
