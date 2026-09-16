#!/bin/bash
set -e

plan_file="${1:-}"
output_file="${2:-destroy-output.txt}"

if [[ -n "$plan_file" && -f "$plan_file" ]]; then
  tofu destroy -no-color "$plan_file" 2>&1 | tee "$output_file"
else
  tofu destroy -auto-approve -no-color 2>&1 | tee "$output_file"
fi
exit_code=${PIPESTATUS[0]}
echo "destroy_output_file=${output_file}" >> "$GITHUB_OUTPUT"
exit $exit_code
