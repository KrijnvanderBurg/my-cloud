variable "name" {
  description = "Display name for the service principal and application"
  type        = string
}

variable "scope" {
  description = "The ID scope for RBAC assignment (e.g., /subscriptions/{subscriptionId})"
  type        = string
}

variable "role_name" {
  description = "The Azure role to assign (e.g., 'Contributor', 'Reader')"
  type        = string
}

variable "subjects" {
  description = "List of federation subjects for GitHub OIDC trust (e.g., 'repo:org/repo:ref:refs/heads/main')"
  type        = list(string)
}
