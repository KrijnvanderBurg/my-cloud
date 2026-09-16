output "login" {
  description = "The login of the identity user"
  value       = ovh_me_identity_user.this.login
}

output "urn" {
  description = "The URN of the identity user"
  value       = ovh_me_identity_user.this.urn
}

output "email" {
  description = "The email of the identity user"
  value       = ovh_me_identity_user.this.email
}

output "status" {
  description = "The current status of the identity user"
  value       = ovh_me_identity_user.this.status
}
