# AWS Account Baseline Terraform Module

This module configures an AWS account within an AWS Organization.

## Usage

``` terraform


```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tf"></a> [tf](#module\_tf) | terraform-aws-modules/s3-bucket/aws | 3.11.0 |

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.ops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.sec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_iam_account_password_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_policy.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.terraform_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.terraform_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The AWS Account ID to configure. | `string` | n/a | yes |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | The AWS account name. | `string` | n/a | yes |
| <a name="input_account_password_policy"></a> [account\_password\_policy](#input\_account\_password\_policy) | The password requirements for the IAM users. | <pre>object({<br>    minimum_password_length        = number<br>    max_password_age               = number<br>    password_reuse_prevention      = number<br>    require_lowercase_characters   = bool<br>    require_numbers                = bool<br>    require_uppercase_characters   = bool<br>    require_symbols                = bool<br>    allow_users_to_change_password = bool<br>  })</pre> | <pre>{<br>  "allow_users_to_change_password": true,<br>  "max_password_age": 90,<br>  "minimum_password_length": 14,<br>  "password_reuse_prevention": 6,<br>  "require_lowercase_characters": true,<br>  "require_numbers": true,<br>  "require_symbols": true,<br>  "require_uppercase_characters": true<br>}</pre> | no |
| <a name="input_baseline_settings"></a> [baseline\_settings](#input\_baseline\_settings) | Enable or disable various baseline settings. | <pre>object({<br>    update_password_policy        = bool<br>    enable_default_ebs_encryption = bool<br>    create_tf_iam_role            = bool<br>    update_alternative_contacts   = bool<br>  })</pre> | <pre>{<br>  "create_tf_iam_role": true,<br>  "enable_default_ebs_encryption": true,<br>  "update_alternative_contacts": true,<br>  "update_password_policy": true<br>}</pre> | no |
| <a name="input_billing_account_contacts"></a> [billing\_account\_contacts](#input\_billing\_account\_contacts) | The alternate Billing contact will receive billing-related notifications, such as invoice availability notifications. | <pre>object({<br>    name          = string<br>    title         = string<br>    email_address = string<br>    phone_number  = string<br>  })</pre> | n/a | yes |
| <a name="input_create_tf_bucket"></a> [create\_tf\_bucket](#input\_create\_tf\_bucket) | (optional) Whether to create the Terraform S3 backend bucket. | `bool` | `true` | no |
| <a name="input_custom_iam_policy"></a> [custom\_iam\_policy](#input\_custom\_iam\_policy) | A custom IAM policy for this account. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name for this account. | `string` | n/a | yes |
| <a name="input_mgmt_account_id"></a> [mgmt\_account\_id](#input\_mgmt\_account\_id) | The management AWS Account ID. | `string` | n/a | yes |
| <a name="input_operations_account_contacts"></a> [operations\_account\_contacts](#input\_operations\_account\_contacts) | The alternate Operations contact will receive operations-related notifications. | <pre>object({<br>    name          = string<br>    title         = string<br>    email_address = string<br>    phone_number  = string<br>  })</pre> | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The label or functional role of the AWS account. | `string` | n/a | yes |
| <a name="input_security_account_contacts"></a> [security\_account\_contacts](#input\_security\_account\_contacts) | The alternate Security contact will receive security notifications, including notifications from the AWS Abuse Team. For additional AWS security-related notifications, please access the Security Bulletins RSS Feed. | <pre>object({<br>    name          = string<br>    title         = string<br>    email_address = string<br>    phone_number  = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the account resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mfa_reminder"></a> [mfa\_reminder](#output\_mfa\_reminder) | n/a |
| <a name="output_terraform_role_arn"></a> [terraform\_role\_arn](#output\_terraform\_role\_arn) | The Terraform IAM role arn. |
| <a name="output_terraform_state_bucket_name"></a> [terraform\_state\_bucket\_name](#output\_terraform\_state\_bucket\_name) | The account's terraform state bucket name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Author

Waleed from <https://cloudly.engineer>
