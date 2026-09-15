# OVHcloud - Levendaal

Terraform/OpenTofu configuration for the OVHcloud Public Cloud platform.
Structure mirrors `02-azure`: each stack lives under `NN-<stack>/environments/<env>`
with reusable `NN-<stack>/modules`.

```
03-ovhcloud
└── 01-platform-management
    ├── environments
    │   └── dev
    └── modules
```

## Remote State

State is stored in the OVHcloud Object Storage (S3) bucket
`rg-tfstate-co-dev-par-01` (region `par`), in the Public Cloud project
`ovh-pl-management-co-dev-na-01` (`f350cf3e972b41fca80eb0a0a1b69dbf`).

The static backend settings (bucket, region, endpoint) live in each stack's
`backend.tf`; only the per-stack `key` is supplied at init.

## Local usage

1. Export the Object Storage S3 credentials (used by the `s3` backend):

   ```sh
   export AWS_ACCESS_KEY_ID="<OVH_OBJECT_STORAGE_ACCESS_KEY>"
   export AWS_SECRET_ACCESS_KEY="<OVH_OBJECT_STORAGE_SECRET_KEY>"
   ```

2. Export the OVH API credentials (used by the `ovh` provider):

   ```sh
   export OVH_ENDPOINT="ovh-eu"
   export OVH_APPLICATION_KEY="<OVH_APPLICATION_KEY>"
   export OVH_APPLICATION_SECRET="<OVH_APPLICATION_SECRET>"
   export OVH_CONSUMER_KEY="<OVH_CONSUMER_KEY>"
   ```

3. Copy the examples and initialize:

   ```sh
   cd 01-platform-management/environments/dev
   cp backend.hcl.example backend.hcl
   cp terraform.tfvars.example terraform.tfvars
   tofu init -backend-config=backend.hcl
   tofu plan
   ```

## CI authentication

The `opentofu-deployment-ovh-template.yml` reusable workflow injects credentials
from GitHub Secrets on the `dev` environment:

| Purpose                  | GitHub Secret                |
| ------------------------ | ---------------------------- |
| OVH API secret           | `OVH_APPLICATION_SECRET`     |
| OVH API consumer key     | `OVH_CONSUMER_KEY`           |
| Object Storage S3 key    | `OVH_S3_ACCESS_KEY_ID`       |
| Object Storage S3 secret | `OVH_S3_SECRET_ACCESS_KEY`   |

`OVH_APPLICATION_KEY` and `OVH_ENDPOINT` are non-secret workflow inputs.

Rotate any credentials that have been committed or shared outside a secret
manager before continuing. Give each independently applied root module a
distinct state key.