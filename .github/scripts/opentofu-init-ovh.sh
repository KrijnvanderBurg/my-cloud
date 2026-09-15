#!/bin/bash
set -e

echo "Initializing OpenTofu with OVH S3 remote backend..."
echo "State key: ${STATE_KEY}"

tofu init -backend-config="key=${STATE_KEY}"
