#!/bin/bash
set -e

echo "Initializing OpenTofu with backend configuration from backend.tf..."

tofu init
