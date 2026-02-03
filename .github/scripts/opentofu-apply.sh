#!/bin/bash
target_path="${1:?Target path is required}"
plan_file="${2:?Plan file is required}"
output_file="${3:-}"

cd "$target_path" || exit 1

# Run apply and capture output if output file is specified
if [[ -n "$output_file" ]]; then
  tofu apply -no-color "$plan_file" 2>&1 | tee "$output_file"
  exit_code=${PIPESTATUS[0]}
  echo "apply_output_file=${output_file}" >> "$GITHUB_OUTPUT"
  exit $exit_code
else
  tofu apply "$plan_file"
fi
