# OVHcloud requires a password when creating an identity user, but secrets must
# not be stored in Terraform source. A random password is generated so the user
# is created in a valid state; the user then sets their own password through the
# OVHcloud "forgotten password" flow. The generated value is ignored on
# subsequent applies so out-of-band password changes do not cause drift.
resource "random_password" "this" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}"
}

resource "ovh_me_identity_user" "this" {
  login       = var.login
  email       = var.email
  description = var.description
  group       = var.group
  password    = random_password.this.result

  lifecycle {
    ignore_changes = [password]
    # prevent_destroy = true
  }
}
