#!/bin/bash
set -euo pipefail

target_path="${1:?Target path is required}"
output_file="destroy-output.txt"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1

tofu destroy -auto-approve -no-color 2>&1 | tee "$output_file"
exit_code=${PIPESTATUS[0]}
echo "destroy_output_file=${output_file}" >> "$GITHUB_OUTPUT"
exit $exit_code
