resource "ovh_me_identity_group" "this" {
  name        = var.name
  description = var.description
  # role governs legacy OVHcloud manager access; permissions are granted through
  # IAM policies instead, so groups default to NONE (least privilege).
  role = var.role
}
