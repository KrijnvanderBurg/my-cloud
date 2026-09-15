locals {
  # ---------------------------------------------------------------------------
  # Environment Configuration
  # ---------------------------------------------------------------------------
  environment = "dev"

  common_tags = {
    environment = local.environment
    managed_by  = "opentofu"
    project     = "levendaal"
    layer       = "platform-identity"
    owner       = "kvdb"
    cost_center = "platform"
  }

  # ---------------------------------------------------------------------------
  # User Groups
  # ---------------------------------------------------------------------------
  # Permissions are granted through IAM policies (see main.tf), so groups use the
  # NONE legacy role to keep them least-privileged by default.
  groups = {
    "platform-admins" = {
      description = "Platform administrators - full account and resource management"
      role        = "NONE"
    }
    "developers" = {
      description = "Developers - manage cloud resources, excluding account/billing/identity"
      role        = "NONE"
    }
    "read-only" = {
      description = "Read-only users - view-only access"
      role        = "NONE"
    }
  }

  # ---------------------------------------------------------------------------
  # IAM Policy Actions (WHO + RESOURCE + ACTION)
  # ---------------------------------------------------------------------------
  # Action strings follow the OVHcloud "<type>:apiovh:<path>" format. These are
  # data-driven starting points; extend `read_only.allow` per resource type (for
  # example using the ovh_iam_reference_actions data source) as services are
  # adopted.
  policy_actions = {
    # Administrators require full control of the account. OVHcloud has no more
    # granular grant that covers every service, so a wildcard allow is used.
    platform_admin = {
      allow  = ["*"]
      except = []
      deny   = []
    }

    # Developers manage resources but must not manage the account, billing or
    # IAM/identity. Everything under the account:apiovh namespace (which includes
    # billing and me/identity/*) is denied.
    developer = {
      allow  = ["*"]
      except = []
      deny   = ["account:apiovh:*"]
    }

    # Read-only users get an explicit view-only starting set. Extend this list as
    # more services are onboarded rather than granting wildcards.
    read_only = {
      allow = [
        "account:apiovh:me/get",
        "account:apiovh:services/get",
      ]
      except = []
      deny   = []
    }

    # The terraform service account manages the identity resources in this stack
    # (users, groups, policies, service accounts), which all live under the
    # account:apiovh namespace. Tighten this with verified action names from the
    # ovh_iam_reference_actions data source (type = "account") as needed.
    terraform = {
      allow  = ["account:apiovh:*"]
      except = []
      deny   = []
    }
  }
}
