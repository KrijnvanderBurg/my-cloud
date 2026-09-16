#!/bin/bash
# Import resources that exist in Azure but not in state after code refactoring

set -e

cd "02-azure/04-platform-landing-zones/environments/drives-dev"

echo "Importing resources that were moved from environment to stack/module level..."

# Import resource group (if not already in state)
echo "Importing resource group..."
terraform import -allow-missing-config \
  module.baseline.module.landing_zone.azurerm_resource_group.this \
  "/subscriptions/9af01e5c-f933-4b86-a389-a8ac837965a5/resourceGroups/rg-connectivity-drives-dev-weu-01" \
  || echo "Resource group already in state or import failed"

# Import log analytics data export rule
echo "Importing log analytics data export rule..."
terraform import -allow-missing-config \
  module.baseline.module.landing_zone.azurerm_log_analytics_data_export_rule.to_storage \
  "rg-connectivity-drives-dev-weu-01/law-drives-dev-weu-01/export-to-storage" \
  || echo "Log analytics data export already in state or import failed"

# Import vnet diagnostic setting
echo "Importing vnet diagnostic setting..."
terraform import -allow-missing-config \
  module.baseline.module.landing_zone.azurerm_monitor_diagnostic_setting.vnet \
  "/subscriptions/9af01e5c-f933-4b86-a389-a8ac837965a5/resourceGroups/rg-connectivity-drives-dev-weu-01/providers/Microsoft.Network/virtualNetworks/vnet-spoke-drives-dev-weu-01|diag-vnet-spoke-drives-dev-weu-01" \
  || echo "Vnet diagnostic setting already in state or import failed"

# Import key vault diagnostic setting
echo "Importing key vault diagnostic setting..."
terraform import -allow-missing-config \
  module.baseline.module.landing_zone.azurerm_monitor_diagnostic_setting.key_vault \
  "/subscriptions/9af01e5c-f933-4b86-a389-a8ac837965a5/resourceGroups/rg-connectivity-drives-dev-weu-01/providers/Microsoft.KeyVault/vaults/kv-drives-dev-weu-01|diag-kv-drives-dev-weu-01" \
  || echo "Key vault diagnostic setting already in state or import failed"

echo "Import complete!"
