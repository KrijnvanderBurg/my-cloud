# Azure - Levendaal
Terraform/OpenTofu configuration for Levendaal.

- See [docs/naming-convention.md](docs/naming-convention.md) for full naming standards.

## Repository

```
.
├── .devcontainer
├── .github
│   ├── actions
│   ├── scripts
│   └── workflows
├── docs
├── 01-platform-management
│   ├── environments
│   │   └── dev
│   └── modules
│       ├── 01-management-group
│       └── 02-policy-deny-delete
├── 02-platform-identity
│   ├── environments
│   │   └── dev
│   └── modules
│       ├── 01-service-principal-federated
│       ├── 02a-rbac-pl-connectivity
│       ├── 02b-rbac-plz
│       ├── 03-entra-group
│       └── 04-monitoring-alerts
├── 03-platform-connectivity
│   ├── environments
│   │   ├── dev-glb
│   │   ├── dev-gwc
│   │   └── dev-weu
│   └── modules
│       ├── 01-hub-vnet
│       └── 02-hub-peering
└── 04-platform-landing-zones
    ├── environments
    │   └── drives-dev
    │       └── .terraform
    │           └── modules
    └── modules
        ├── 01-base-package
        └── 02-aks-package
```

## Deployment History
All steps performed to setup initial infrastructure and to current state.

1. **Created Azure Tenant** (`Levendaal`) via Azure Portal.
2. **Created Subscription** (`pl-management-co-dev-na-01`/`e388ddce-c79d-4db0-8a6f-cd69b1708954`) via Azure Portal
3. **Created Storage Account for remote tfstate:**
   ```bash
   az login
   az account set --subscription "e388ddce-c79d-4db0-8a6f-cd69b1708954"
   az group create --name "rg-tfstate-co-dev-gwc-01" --location "germanywestcentral"
   az storage account create --name "sttfstatecodevgwc01" --resource-group "rg-tfstate-co-dev-gwc-01" --location "germanywestcentral" --sku "Standard_LRS"
   az storage container create --name "tfstate-pl-management" --account-name "sttfstatecodevgwc01"
   az storage container create --name "tfstate-pl-identity" --account-name "sttfstatecodevgwc01"
   ```
4. **Configured backend** in `environments/dev/backend.tf`
5. **Manually associate subscriptions to management groups:**
   ```bash
   # Associate each subscription to its management group
   az account management-group subscription add \
     --name "mg-pl-management-dev-na-01" \
     --subscription "e388ddce-c79d-4db0-8a6f-cd69b1708954"

   az account management-group subscription add \
     --name "mg-pl-identity-dev-na-01" \
     --subscription "9312c5c5-b089-4b62-bb90-0d92d421d66c"

   az account management-group subscription add \
     --name "mg-pl-connectivity-dev-na-01" \
     --subscription "6018b0fb-7b8c-491f-8abf-375d2c07ef97"

   az account management-group subscription add \
     --name "mg-landingzone-dev-na-01" \
     --subscription "4111975b-f6ca-4e08-b7b6-87d7b6c35840"
   ```
   **Note:** This requires Owner or User Access Administrator on each subscription. Done manually to avoid granting excessive permissions to service principals.

6. **Created sp-platform-management Service Principal (Manual - Identity deployment comes later):**
   ```bash
   # Create app and service principal
   az ad app create --display-name "sp-pl-management-co-dev-na-01"
   az ad sp create --id $(az ad app list --display-name "sp-platform-management-co-dev-na-01" --query "[0].appId" -o tsv)

   # Create GitHub federated credential
   az ad app federated-credential create \
     --id $(az ad app list --display-name "sp-platform-management-co-dev-na-01" --query "[0].id" -o tsv) \
     --parameters '{"name":"github-dev","issuer":"https://token.actions.githubusercontent.com","subject":"repo:KrijnvanderBurg/my-cloud:environment:dev","audiences":["api://AzureADTokenExchange"]}'

   # Assign roles
   SP_ID=$(az ad sp list --display-name "sp-platform-management-co-dev-na-01" --query "[0].id" -o tsv)

   az role assignment create --assignee $SP_ID --role "Management Group Contributor" \
     --scope "/providers/Microsoft.Management/managementGroups/90d27970-b92c-43dc-9935-1ed557d8e20e"

   az role assignment create --assignee $SP_ID --role "Resource Policy Contributor" \
     --scope "/providers/Microsoft.Management/managementGroups/90d27970-b92c-43dc-9935-1ed557d8e20e"

   az role assignment create --assignee $SP_ID --role "User Access Administrator" \
     --scope "/providers/Microsoft.Management/managementGroups/90d27970-b92c-43dc-9935-1ed557d8e20e"

   az role assignment create --assignee $SP_ID --role "Storage Blob Data Contributor" \
     --scope "/subscriptions/e388ddce-c79d-4db0-8a6f-cd69b1708954/resourceGroups/rg-tfstate-co-dev-gwc-01/providers/Microsoft.Storage/storageAccounts/sttfstatecodevgwc01"
   ```

7. **Created sp-platform-identity Service Principal (Manual - Cannot Manage Itself):**
    ```bash
    # Create app and service principal
    az ad app create --display-name "sp-pl-identity-co-dev-na-01"
    az ad sp create --id $(az ad app list --display-name "sp-platform-identity-co-dev-na-01" --query "[0].appId" -o tsv)

    # Create GitHub federated credential
    az ad app federated-credential create \
      --id $(az ad app list --display-name "sp-platform-identity-co-dev-na-01" --query "[0].id" -o tsv) \
      --parameters '{"name":"github-dev","issuer":"https://token.actions.githubusercontent.com","subject":"repo:KrijnvanderBurg/my-cloud:environment:dev","audiences":["api://AzureADTokenExchange"]}'

    # Add Graph API permissions
    APP_ID=$(az ad app list --display-name "sp-platform-identity-co-dev-na-01" --query "[0].appId" -o tsv)
    az ad app permission add --id $APP_ID --api 00000003-0000-0000-c000-000000000000 --api-permissions 1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9=Role
    az ad app permission add --id $APP_ID --api 00000003-0000-0000-c000-000000000000 --api-permissions 62a82d76-70ea-41e2-9197-370581804d09=Role
    az ad app permission add --id $APP_ID --api 00000003-0000-0000-c000-000000000000 --api-permissions 9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8=Role
    az ad app permission admin-consent --id $APP_ID

    # Assign roles
    SP_ID=$(az ad sp list --display-name "sp-platform-identity-co-dev-na-01" --query "[0].id" -o tsv)

    az role assignment create --assignee $SP_ID --role "Contributor" \
      --scope "/subscriptions/9312c5c5-b089-4b62-bb90-0d92d421d66c"

    az role assignment create --assignee "2972657a-4e99-44c6-80f8-1e265595c81b" --role "User Access Administrator" \
      --scope "/providers/Microsoft.Management/managementGroups/90d27970-b92c-43dc-9935-1ed557d8e20e"

    az role assignment create --assignee $SP_ID --role "Storage Blob Data Contributor" \
      --scope "/subscriptions/e388ddce-c79d-4db0-8a6f-cd69b1708954/resourceGroups/rg-tfstate-co-dev-gwc-01/providers/Microsoft.Storage/storageAccounts/sttfstatecodevgwc01"
    ```
    **Note:** Admin consent requires Global Administrator or Privileged Role Administrator role. If CLI fails, grant via Portal:
    Azure AD → App registrations → sp-platform-identity-co-dev-na-01 → API permissions → Grant admin consent
