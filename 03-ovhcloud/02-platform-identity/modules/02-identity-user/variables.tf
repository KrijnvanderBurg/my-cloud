variable "login" {
  description = "User's login suffix (unique identifier for the identity user)"
  type        = string
}

variable "email" {
  description = "User's email address"
  type        = string
}

variable "description" {
  description = "User description"
  type        = string
  default     = ""
}

variable "group" {
  description = "Name of the single identity group the user belongs to (OVHcloud users belong to exactly one group)"
  type        = string
}
