variable "name" {
  description = "Identity group name (used as the group identifier and in IAM policies)"
  type        = string
}

variable "description" {
  description = "Identity group description"
  type        = string
  default     = ""
}

variable "role" {
  description = "Legacy OVHcloud manager role for the group. Prefer NONE and grant access via IAM policies."
  type        = string
  default     = "NONE"

  validation {
    condition     = contains(["ADMIN", "REGULAR", "UNPRIVILEGED", "NONE"], var.role)
    error_message = "role must be one of ADMIN, REGULAR, UNPRIVILEGED, or NONE."
  }
}
