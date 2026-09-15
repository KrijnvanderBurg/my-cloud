resource "ovh_iam_policy" "this" {
  name        = var.name
  description = var.description

  identities = var.identities
  resources  = var.resources

  allow  = var.allow
  except = var.except
  deny   = var.deny
}
