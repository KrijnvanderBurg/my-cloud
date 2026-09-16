output "identity" {
  description = "Identity URN of the service account, used as an identity in IAM policies"
  value       = ovh_me_api_oauth2_client.this.identity
}

output "name" {
  description = "The name of the service account"
  value       = ovh_me_api_oauth2_client.this.name
}

# Credentials are exported as sensitive so they can be wired internally but are
# never printed. The consuming stack must NOT re-expose these through outputs.
output "client_id" {
  description = "OAuth2 client ID of the service account"
  value       = ovh_me_api_oauth2_client.this.client_id
  sensitive   = true
}

output "client_secret" {
  description = "OAuth2 client secret of the service account (only available at creation)"
  value       = ovh_me_api_oauth2_client.this.client_secret
  sensitive   = true
}
