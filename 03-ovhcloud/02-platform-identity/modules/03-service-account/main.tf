# OVHcloud has no dedicated "service account" resource. The native equivalent for
# machine-to-machine automation is an OAuth2 client using the CLIENT_CREDENTIALS
# flow, which produces a service-account identity (URN) usable in IAM policies.
resource "ovh_me_api_oauth2_client" "this" {
  name        = var.name
  description = var.description
  flow        = "CLIENT_CREDENTIALS"
}
