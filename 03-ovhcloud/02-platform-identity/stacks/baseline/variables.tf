# =============================================================================
# Platform Identity Baseline Stack - Variables
# =============================================================================
# All variables required to construct platform identity resources.
# No defaults - each environment MUST supply all values explicitly.

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)"
  type        = string
}

variable "users" {
  description = "User definitions mapping login to email, description, and group membership"
  type = map(object({
    email       = string
    description = string
    group       = string
  }))
}

variable "service_accounts" {
  description = "Service account definitions mapping name to description"
  type = map(object({
    description = string
  }))
}

variable "groups" {
  description = "Group definitions mapping name to description and role"
  type = map(object({
    description = string
    role        = string
  }))
}

variable "policy_actions" {
  description = "IAM policy action definitions for different identity roles"
  type = object({
    platform_admin = object({
      allow  = list(string)
      except = list(string)
      deny   = list(string)
    })
    developer = object({
      allow  = list(string)
      except = list(string)
      deny   = list(string)
    })
    read_only = object({
      allow  = list(string)
      except = list(string)
      deny   = list(string)
    })
    terraform = object({
      allow  = list(string)
      except = list(string)
      deny   = list(string)
    })
  })
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
