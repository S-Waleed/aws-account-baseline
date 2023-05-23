variable "environment" {
  type        = string
  description = "The environment name for this account."
}

variable "account_name" {
  type        = string
  description = "The AWS account name."
}

variable "mgmt_account_id" {
  type        = string
  description = "The management AWS Account ID."
}

variable "terraform_state_bucket_name" {
  type        = string
  description = "The accounts terraform state S3 bucket name."
}

variable "billing_account_contacts" {
  type = object({
    name          = string
    title         = string
    email_address = string
    phone_number  = string
  })
  description = "The alternate Billing contact will receive billing-related notifications, such as invoice availability notifications."
}

variable "operations_account_contacts" {
  type = object({
    name          = string
    title         = string
    email_address = string
    phone_number  = string
  })
  description = "The alternate Operations contact will receive operations-related notifications."
}

variable "security_account_contacts" {
  type = object({
    name          = string
    title         = string
    email_address = string
    phone_number  = string
  })
  description = "The alternate Security contact will receive security notifications, including notifications from the AWS Abuse Team. For additional AWS security-related notifications, please access the Security Bulletins RSS Feed."
}

variable "account_password_policy" {
  type = object({
    minimum_password_length        = number
    max_password_age               = number
    password_reuse_prevention      = number
    require_lowercase_characters   = bool
    require_numbers                = bool
    require_uppercase_characters   = bool
    require_symbols                = bool
    allow_users_to_change_password = bool
  })

  default = {

    minimum_password_length        = 14
    max_password_age               = 90
    password_reuse_prevention      = 6
    require_lowercase_characters   = true
    require_numbers                = true
    require_uppercase_characters   = true
    require_symbols                = true
    allow_users_to_change_password = true
  }
  description = "The password requirements for the IAM users."
}

variable "custom_iam_policy" {
  type        = string
  description = "A custom IAM policy for this account."
}
