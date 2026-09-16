variable "name" {
  description = "Unique name of the IAM policy"
  type        = string
}

variable "description" {
  description = "Description of the IAM policy"
  type        = string
  default     = ""
}

variable "identities" {
  description = "Set of identity URNs (groups or service accounts) the policy applies to"
  type        = set(string)
}

variable "resources" {
  description = "Set of resource URNs the policy applies to"
  type        = set(string)
}

variable "allow" {
  description = "Set of actions allowed on the resources"
  type        = set(string)
  default     = []
}

variable "except" {
  description = "Set of actions subtracted from allow (only meaningful when allow contains wildcards)"
  type        = set(string)
  default     = []
}

variable "deny" {
  description = "Set of actions always denied, even if allowed elsewhere"
  type        = set(string)
  default     = []
}
