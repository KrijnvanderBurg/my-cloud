#!/bin/bash
target_path="${1:-$PWD/infrastructure}" && echo "Planning OpenTofu changes in: $target_path"
var_file="${2:-}" && [[ -n "$var_file" ]] && echo "Using variables file: $var_file"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1

plan_file="/tmp/opentofu-plan-output.txt"
tofu plan -no-color ${var_file:+-var-file="$var_file"} 2>&1 | tee "$plan_file"
exitcode=${PIPESTATUS[0]}

[[ -n "$GITHUB_OUTPUT" ]] && echo "plan_file=$plan_file" >> "$GITHUB_OUTPUT"

exit $exitcode
