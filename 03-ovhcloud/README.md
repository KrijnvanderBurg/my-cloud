# OVHcloud - Levendaal

Terraform/OpenTofu configuration for the OVHcloud Public Cloud platform.
Structure mirrors `02-azure`: each stack lives under `NN-<stack>/environments/<env>`
with reusable `NN-<stack>/modules`.

```
03-ovhcloud
├── 01-platform-management
│   ├── environments
│   │   └── dev
│   └── modules
│       ├── 01-iam                  # IAM resource group + optional policy
│       └── 02-project-s3-user      # Project user + S3 credential + S3 policy
└── 02-platform-identity            # IAM foundation (users, groups, SA, policies)
    ├── environments
    │   └── dev
    └── modules
        ├── 01-identity-group       # ovh_me_identity_group
        ├── 02-identity-user        # ovh_me_identity_user (+ generated password)
        ├── 03-service-account      # ovh_me_api_oauth2_client (CLIENT_CREDENTIALS)
        └── 04-iam-policy           # ovh_iam_policy
```

## IAM foundation (`02-platform-identity`)

A reusable, OVHcloud-native IAM foundation that mirrors the layout of
`02-azure/02-platform-identity`:

- **Human users** are data-driven through the `users` variable in
  `environments/dev/variables.tf`.
- **Groups** `platform-admins`, `developers` and `read-only` are defined in
  `locals.tf`; permissions are granted to groups (not individual users) via IAM
  policies.
- **One service account** (`terraform`) is created as an OAuth2 client using the
  `CLIENT_CREDENTIALS` flow — OVHcloud's native machine identity.
- **IAM policies** `iam-human-platform-admin`, `iam-human-developer`,
  `iam-human-read-only` and `iam-terraform` bind identities to account-scoped
  actions.

### OVHcloud limitations (by design)

- **One group per user.** An `ovh_me_identity_user` belongs to exactly one
  identity group, so the user's `group` is a single string rather than a set.
- **User passwords.** OVHcloud requires a password at user creation. No secret is
  stored in source: a `random_password` is generated (and ignored on later
  applies) so each user is created in a valid state and then sets their own
  password through the OVHcloud "forgotten password" flow.
- **Service-account secret.** The OAuth2 `client_secret` is only returned at
  creation and lives in state; it is never exposed through outputs. Retrieve it
  once from state during bootstrap, then store it in a secret manager:

  ```sh
  tofu state pull \
    | jq -r '.resources[]
        | select(.module=="module.service_account[\"terraform\"]" and .type=="ovh_me_api_oauth2_client")
        | .instances[0].attributes | "client_id="+.client_id, "client_secret="+.client_secret'
  ```

  Service accounts are data-driven via the `service_accounts` variable, so extra
  automation identities can be added without code changes.
- **Root / break-glass account.** The root account is not managed by Terraform
  and is not used for automation; the dedicated `terraform` service account is
  used for normal operations.

## Remote State

State is stored in the OVHcloud Object Storage (S3) bucket
`rg-tfstate-co-dev-par-01` (region `eu-west-par`), in the Public Cloud project
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

3. Initialize with the stack's state key and plan:

   ```sh
   cd 01-platform-management/environments/dev
   tofu init -backend-config="key=ovh/pl-management/dev.tfstate"
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
