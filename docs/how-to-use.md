# How to Use the GitHub OIDC Terraform Module

This guide explains how to use the GitHub OIDC (OpenID Connect) Terraform module to set up secure authentication between GitHub Actions and AWS.

## Prerequisites

- Terraform installed (version 0.12 or later)
- AWS account with appropriate permissions
- GitHub organization and repositories

## Basic Usage

```hcl
module "github_oidc" {
  source = "path/to/this/module"

  github_org         = "your-org-name"
  github_repositories = ["repo1", "repo2"]
}
```

## Required Inputs

| Name | Description | Type |
|------|-------------|------|
| `github_org` | Your GitHub organization name | string |
| `github_repositories` | List of GitHub repository names that will have access to AWS | list(string) |

## Optional Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `client_id_list` | List of client IDs | list(string) | `["sts.amazonaws.com"]` |
| `iam_role_name` | Name of the IAM role | string | `"GitHubOIDCRole"` |
| `iam_role_path` | Path for the IAM role | string | `"/"` |
| `iam_role_description` | Description of the role | string | `"IAM role to enable GitHub OIDC access"` |
| `iam_default_policy_arn` | List of AWS managed policy ARNs | list(string) | `[]` |
| `iam_custom_policy` | Custom IAM policy configuration | object | `null` |
| `max_session_duration` | Maximum session duration in seconds | number | `3600` |
| `oidc_url` | OIDC provider URL | string | `"https://token.actions.githubusercontent.com"` |
| `thumbprint_list` | List of OIDC provider certificate thumbprints | list(string) | `["6938fd4d98bab03faadb97b34396831e3780aea1"]` |

## Examples

### Basic Configuration

```hcl
module "github_oidc" {
  source = "path/to/this/module"

  github_org         = "your-org-name"
  github_repositories = ["repo1", "repo2"]
}
```

### With Custom Policy

```hcl
module "github_oidc" {
  source = "path/to/this/module"

  github_org         = "your-org-name"
  github_repositories = ["repo1", "repo2"]

  iam_custom_policy = {
    template = <<-EOT
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:PutObject"
          ],
          "Resource": "arn:aws:s3:::your-bucket/*"
        }
      ]
    }
    EOT
  }
}
```

### With AWS Managed Policies

```hcl
module "github_oidc" {
  source = "path/to/this/module"

  github_org         = "your-org-name"
  github_repositories = ["repo1", "repo2"]

  iam_default_policy_arn = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}
```

## GitHub Actions Workflow Example

To use the created IAM role in your GitHub Actions workflow:

```yaml
name: AWS OIDC Example
on:
  push:
    branches: [ main ]

permissions:
  id-token: write
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubOIDCRole
          aws-region: us-east-1

      - name: Your AWS commands here
        run: |
          aws s3 ls
```

## What This Module Creates

1. An IAM OIDC provider for GitHub
2. An IAM role with the necessary trust policy
3. IAM role policies (both custom and managed)
4. The necessary role policy attachments

## Security Considerations

- Ensure the GitHub repositories specified have proper access controls
- Use the principle of least privilege when defining custom policies
- Regularly rotate the OIDC provider thumbprint
- Monitor and audit the IAM role usage

## Troubleshooting

If you encounter issues:

1. Verify the GitHub organization and repository names are correct
2. Check that the AWS credentials have sufficient permissions
3. Ensure the OIDC provider thumbprint is up to date
4. Verify the IAM role trust policy is correctly configured
