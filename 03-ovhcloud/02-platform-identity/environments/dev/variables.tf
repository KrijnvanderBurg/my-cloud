# =============================================================================
# Human Users (data-driven)
# =============================================================================
# OVHcloud identity users belong to exactly ONE identity group, so `group` is a
# single string rather than a set. It must reference one of the group keys
# defined in locals.tf.
variable "users" {
  description = "OVHcloud human identity users, keyed by login suffix"

  type = map(object({
    email       = string
    description = optional(string, "")
    group       = string
  }))

  default = {
    alice = {
      email       = "alice@example.com"
      description = "Platform administrator"
      group       = "platform-admins"
    }

    bob = {
      email       = "bob@example.com"
      description = "Developer"
      group       = "developers"
    }

    carol = {
      email       = "carol@example.com"
      description = "Read-only user"
      group       = "read-only"
    }
  }

  validation {
    condition     = alltrue([for u in var.users : contains(["platform-admins", "developers", "read-only"], u.group)])
    error_message = "Each user's group must be one of: platform-admins, developers, read-only."
  }
}

# =============================================================================
# Service Accounts (data-driven)
# =============================================================================
# OVHcloud service accounts are OAuth2 clients using the CLIENT_CREDENTIALS flow.
# The `terraform` entry is required by this stack's iam-terraform policy; add
# more entries for additional automation identities (each gets its own policy).
variable "service_accounts" {
  description = "OVHcloud service accounts (OAuth2 client_credentials) for automation, keyed by name"

  type = map(object({
    description = optional(string, "")
  }))

  default = {
    terraform = {
      description = "Service account for Terraform automation (platform-identity)"
    }
  }
}
