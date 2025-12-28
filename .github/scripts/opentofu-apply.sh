#!/bin/bash
target_path="${1:?Target path is required}"
plan_file="${2:?Plan file is required}"

source "$(dirname "$0")/opentofu-install.sh"

cd "$target_path" || exit 1
tofu apply "$plan_file"
