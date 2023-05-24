locals {
    terraform_state_bucket_name = "terraform-state-network-${var.account_id}"
}

###############################################
# IAM assumable role with custom trust policy
###############################################

# IAM role
resource "aws_iam_role" "terraform" {
  count = var.baseline_settings.create_tf_iam_role == true ? 1 : 0

  name                 = "svc-terraform-role"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = format("arn:aws:iam::%s:root", var.mgmt_account_id)
        }

        Condition : {
          StringEquals : {
            "aws:PrincipalOrgID" : [
              data.aws_organizations_organization.this.id
            ]
          }
        }
      }
    ]
  })

  tags = {
    Name = var.account_name
  }
}

# S3 backend policy
resource "aws_iam_policy" "terraform_bucket" {
  count = var.baseline_settings.create_tf_iam_role == true ? 1 : 0

  name        = "svc-terraform-bucket-policy"
  path        = "/"
  description = "IAM policy for access to the s3 backend bucket."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "TfPermissionsList"
        Action = [
          "s3:ListBucket",

        ]
        Effect = "Allow"
        Resource : [
          "arn:aws:s3:::${local.terraform_state_bucket_name}"
        ]
      },
      {
        Sid = "TfPermissions"
        Action = [
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:PutObject",

        ]
        Effect = "Allow"
        Resource : [
          "arn:aws:s3:::${local.terraform_state_bucket_name}"
        ]
      }
    ]
  })
}

# Custom policy
resource "aws_iam_policy" "terraform" {
  count = var.baseline_settings.create_tf_iam_role == true ? 1 : 0

  name        = "svc-terraform-role-policy"
  path        = "/"
  description = "IAM policy for svc-terraform-role"
  policy      = var.custom_iam_policy
}

resource "aws_iam_role_policy_attachment" "terraform_bucket" {
  count = var.baseline_settings.create_tf_iam_role == true ? 1 : 0

  role       = aws_iam_role.terraform[0].name
  policy_arn = aws_iam_policy.terraform_bucket[0].arn
}

resource "aws_iam_role_policy_attachment" "terraform" {
  count = var.baseline_settings.create_tf_iam_role == true ? 1 : 0

  role       = aws_iam_role.terraform[0].name
  policy_arn = aws_iam_policy.terraform[0].arn
}

###############################################
# Account Contacts
###############################################

resource "aws_account_alternate_contact" "billing" {
  count = var.baseline_settings.update_alternative_contacts == true ? 1 : 0

  alternate_contact_type = "BILLING"

  name          = var.billing_account_contacts.name
  title         = var.billing_account_contacts.title
  email_address = var.billing_account_contacts.email_address
  phone_number  = var.billing_account_contacts.phone_number
}

resource "aws_account_alternate_contact" "ops" {
  count = var.baseline_settings.update_alternative_contacts == true ? 1 : 0

  alternate_contact_type = "OPERATIONS"

  name          = var.operations_account_contacts.name
  title         = var.operations_account_contacts.title
  email_address = var.operations_account_contacts.email_address
  phone_number  = var.operations_account_contacts.phone_number
}

resource "aws_account_alternate_contact" "sec" {
  count = var.baseline_settings.update_alternative_contacts == true ? 1 : 0

  alternate_contact_type = "SECURITY"

  name          = var.security_account_contacts.name
  title         = var.security_account_contacts.title
  email_address = var.security_account_contacts.email_address
  phone_number  = var.security_account_contacts.phone_number
}


###############################################
# Account Password Settings
###############################################

resource "aws_iam_account_password_policy" "this" {
  count = var.baseline_settings.update_password_policy == true ? 1 : 0

  minimum_password_length        = var.account_password_policy.minimum_password_length
  max_password_age               = var.account_password_policy.max_password_age
  password_reuse_prevention      = var.account_password_policy.password_reuse_prevention
  require_lowercase_characters   = var.account_password_policy.require_lowercase_characters
  require_numbers                = var.account_password_policy.require_numbers
  require_uppercase_characters   = var.account_password_policy.require_uppercase_characters
  require_symbols                = var.account_password_policy.require_symbols
  allow_users_to_change_password = var.account_password_policy.allow_users_to_change_password
}

###############################################
# Encryption Settings
###############################################

resource "aws_ebs_encryption_by_default" "this" {
  count   = var.baseline_settings.enable_default_ebs_encryption == true ? 1 : 0
  enabled = true
}
