#!/bin/bash
set -e

tofu init \
  -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
  -backend-config="resource_group_name=${RESOURCE_GROUP_NAME}" \
  -backend-config="container_name=${CONTAINER_NAME}" \
  -backend-config="key=${STATE_KEY}"
