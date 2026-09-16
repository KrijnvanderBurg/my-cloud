# =============================================================================
# Platform Management Baseline Stack - Variables
# =============================================================================
# All variables required to construct platform management resources.
# No defaults - each environment MUST supply all values explicitly.

variable "project_id" {
  description = "OVHcloud Public Cloud project ID"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod, etc.)"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
