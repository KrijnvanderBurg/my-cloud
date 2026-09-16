# =============================================================================
# Platform Identity Baseline Stack
# =============================================================================
# Shared identity resources (groups, users, service accounts, IAM policies)
# for all environments. All configuration is data-driven via variables passed
# from the environment layer (locals.tf).

# =============================================================================
# Account (root/break-glass)
# =============================================================================
# The root/break-glass account. It is referenced only to scope IAM policies to
# the account URN. It is never managed or used for automation by this stack.
data "ovh_me" "account" {}

# =============================================================================
# User Groups
# =============================================================================
module "group" {
  source   = "../../modules/01-identity-group"
  for_each = var.groups

  name        = each.key
  description = each.value.description
  role        = each.value.role
}

# =============================================================================
# Human Users (data-driven)
# =============================================================================
module "user" {
  source   = "../../modules/02-identity-user"
  for_each = var.users

  login       = each.key
  email       = each.value.email
  description = each.value.description
  group       = each.value.group

  # Ensure the target group exists before the user references it.
  depends_on = [module.group]
}

# =============================================================================
# Service Accounts (data-driven)
# =============================================================================
module "service_account" {
  source   = "../../modules/03-service-account"
  for_each = var.service_accounts

  name        = each.key
  description = each.value.description
}

# =============================================================================
# IAM Policies (group- and service-account-based)
# =============================================================================
module "policy_human_platform_admin" {
  source = "../../modules/04-iam-policy"

  name        = "iam-human-platform-admin"
  description = "Full account and resource management for platform administrators"
  identities  = [module.group["platform-admins"].urn]
  resources   = [data.ovh_me.account.urn]
  allow       = var.policy_actions.platform_admin.allow
  except      = var.policy_actions.platform_admin.except
  deny        = var.policy_actions.platform_admin.deny
}

module "policy_human_developer" {
  source = "../../modules/04-iam-policy"

  name        = "iam-human-developer"
  description = "Resource management for developers, excluding account/billing/identity"
  identities  = [module.group["developers"].urn]
  resources   = [data.ovh_me.account.urn]
  allow       = var.policy_actions.developer.allow
  except      = var.policy_actions.developer.except
  deny        = var.policy_actions.developer.deny
}

module "policy_human_read_only" {
  source = "../../modules/04-iam-policy"

  name        = "iam-human-read-only"
  description = "View-only access for read-only users"
  identities  = [module.group["read-only"].urn]
  resources   = [data.ovh_me.account.urn]
  allow       = var.policy_actions.read_only.allow
  except      = var.policy_actions.read_only.except
  deny        = var.policy_actions.read_only.deny
}

module "policy_terraform" {
  source = "../../modules/04-iam-policy"

  name        = "iam-terraform"
  description = "Least-privilege automation policy for the Terraform service account"
  identities  = [module.service_account["terraform"].identity]
  resources   = [data.ovh_me.account.urn]
  allow       = var.policy_actions.terraform.allow
  except      = var.policy_actions.terraform.except
  deny        = var.policy_actions.terraform.deny
}
