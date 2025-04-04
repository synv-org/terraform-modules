<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id_list"></a> [client\_id\_list](#input\_client\_id\_list) | A list of client IDs (also known as audiences). | `list(string)` | <pre>[<br/>  "sts.amazonaws.com"<br/>]</pre> | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organisation name. | `string` | n/a | yes |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | List of GitHub repository names. | `list(string)` | n/a | yes |
| <a name="input_iam_custom_policy"></a> [iam\_custom\_policy](#input\_iam\_custom\_policy) | Custom Policy of IAM Role | <pre>object({<br/>    template = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_iam_default_policy_arn"></a> [iam\_default\_policy\_arn](#input\_iam\_default\_policy\_arn) | ARN of IAM Default Policies managed by AWS | `list(string)` | `[]` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the role | `string` | `"IAM role to enable GitHub OIDC access"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Friendly name of the role. If omitted, Terraform will assign a random, unique name. | `string` | `"GitHubOIDCRole"` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | Path to the IAM role. | `string` | `"/"` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds. | `number` | `3600` | no |
| <a name="input_oidc_url"></a> [oidc\_url](#input\_oidc\_url) | The URL of the identity provider. Corresponds to the iss claim. | `string` | `"https://token.actions.githubusercontent.com"` | no |
| <a name="input_thumbprint_list"></a> [thumbprint\_list](#input\_thumbprint\_list) | A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s). | `list(string)` | <pre>[<br/>  "6938fd4d98bab03faadb97b34396831e3780aea1"<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->