# output "id" {
#   value       = aws_organizations_account.this.id
#   description = "The AWS account ID."
# }

output "terraform_role_arn" {
  value       = aws_iam_role.terraform[0].arn
  description = "The Terraform IAM role arn."
}

output "mfa_reminder" {
  value = "REMINDER: Reset the root user password, sign in, and set MFA!"
}
