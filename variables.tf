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

variable "account_id" {
  type        = string
  description = "The AWS Account ID to configure."
}

variable "role" {
  type        = string
  description = "The label or functional role of the AWS account."
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

variable "baseline_settings" {
  type = object({
    update_password_policy        = bool
    enable_default_ebs_encryption = bool
    create_tf_iam_role            = bool
    update_alternative_contacts   = bool
  })

  default = {
    update_password_policy        = true
    enable_default_ebs_encryption = true
    create_tf_iam_role            = true
    update_alternative_contacts   = true
  }

  description = "Enable or disable various baseline settings."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the account resources."
  type        = map(string)
  default     = {}
}

variable "create_tf_bucket" {
  type        = bool
  description = "(optional) Whether to create the Terraform S3 backend bucket."
  default     = true
}
