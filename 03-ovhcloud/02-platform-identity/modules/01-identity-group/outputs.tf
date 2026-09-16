output "name" {
  description = "The name of the identity group"
  value       = ovh_me_identity_group.this.name
}

output "urn" {
  description = "The URN of the identity group, used as an identity in IAM policies"
  value       = ovh_me_identity_group.this.urn
}
