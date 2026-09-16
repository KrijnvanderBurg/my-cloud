#!/bin/bash
set -e

echo "Initializing OpenTofu with OVH S3 remote backend from backend.tf..."

tofu init
