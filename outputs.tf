output "terraform_role_arn" {
  value       = aws_iam_role.terraform.arn
  description = "The Terraform IAM role arn."
}

output "mfa_reminder" {
  value = "REMINDER: Reset the root user password, sign in, and set MFA!"
}
