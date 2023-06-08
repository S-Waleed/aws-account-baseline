output "terraform_state_bucket_name" {
  value       = local.terraform_state_bucket_name
  description = "The account's terraform state bucket name."
}

output "terraform_role_arn" {
  value       = aws_iam_role.terraform[0].arn
  description = "The Terraform IAM role arn."
}

output "mfa_reminder" {
  value = "REMINDER: Reset the root user password, sign in, and set MFA!"
}
