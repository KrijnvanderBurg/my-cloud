output "id" {
  description = "The ID of the IAM policy"
  value       = ovh_iam_policy.this.id
}

output "name" {
  description = "The name of the IAM policy"
  value       = ovh_iam_policy.this.name
}
