# Environment structure (Azure platform layers)

Applies to `02-azure/01-platform-management` and `02-azure/02-platform-identity`.

## Three tiers

| Tier | Path | Responsibility |
|------|------|----------------|
| Shared modules | `<layer>/modules/` | Atomic resource building blocks reused across stacks and environments. Zero environment-awareness. |
| Stack compositions | `<layer>/stacks/<stack-name>/` | Baseline composition: each stack defines resources that **must exist in all environments** that call it. Defined once per stack. |
| Environment-specific resources | `<layer>/environments/<env>/modules-env/` | Environment-only customizations (policies, roles, alerts, etc.). Keeps env-specific code visually separate. |
| Environment root | `<layer>/environments/<env>/` | Thin layer: provider + backend + `locals.tf` (env values) + one `module "baseline"` call (from `stacks/`) + references to `./modules-env/*` + `moved {}` blocks for state migration. |

**Key principle**: 
- Every environment calls the same baseline stack → baseline resources are inherited automatically (can't forget them).
- Stack's `variables.tf` uses **required inputs (no defaults)** → environment that forgets to supply a value fails at plan time.
- Environment-only tweaks live in `modules-env/` → visible, explicit, never hidden in conditionals.

## Adding a new environment

1. Copy `environments/dev` to `environments/<env>` (e.g. `test`, `prod`).
2. Delete `modules-env/.gitkeep` if present (it's just a placeholder).
3. In `locals.tf`: set `environment` and the per-environment values (subscription IDs, etc.).
4. In `backend.tf`: point at **that environment's own** tfstate storage account and set
   the key `pl-<layer>-<env>.tfstate`. State storage accounts are **NOT shared** between
   environments.
5. In `providers.tf`: set the environment's `subscription_id` (and, for the identity
   layer, the `terraform_remote_state.management` block to that environment's management
   storage account + key `pl-management-<env>.tfstate`).
6. Run `init` + `validate` + `plan`. No baseline resource needs to be re-added — it is
   inherited from `stacks/baseline/`.
7. Create env-specific resources (if needed) as subdirectories under `modules-env/` and
   call them from `main.tf`.

## Where do environment differences go?

Choose based on whether the resource **exists** everywhere:

### 1. Presence/absence differs → environment-specific module in `modules-env/`

A resource that exists in only some environments (a dev-only PoC, a prod-only guardrail)
is defined in that environment's `modules-env/` subdirectory and called explicitly in
that environment's `main.tf`, under the `Environment-only extras` section. It is visible
and intentional — never hidden behind `count = var.environment == "prod" ? 1 : 0`.

**Example**: `environments/prod/modules-env/policies/prod-strict-policy/`

In `environments/prod/main.tf`:
```hcl
module "policy_strict_prod" {
  source = "./modules-env/policies/prod-strict-policy"
  # ...
}
```

### 2. Same resource, config differs → documented stack variable

A resource that exists in **every** environment but is configured differently per
environment (for example a policy that is enforced `Deny` in prod but `Audit` in dev)
stays in `stacks/baseline/`. Expose the difference as an input variable on the stack.

This pattern is **allowed only when documented**:

- Add a `description` to the variable in `stacks/baseline/variables.tf` listing the
  allowed values and what each environment typically sets.
- Add a one-line comment at the call site in each `environments/<env>/main.tf` where the
  value diverges from the baseline default.
- Record the knob and its current per-environment values in the table below so drift is
  visible at a glance.

#### Config knobs (per-environment)

| Layer | Stack variable | dev | test | prod | Notes |
|-------|----------------|-----|------|------|-------|
| _(none yet)_ | | | | | Add a row when you introduce a config knob. |
