#modules/oidc-github/_variables.tf
variable "oidc_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim."
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "client_id_list" {
  description = "A list of client IDs (also known as audiences)."
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "thumbprint_list" {
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

variable "github_org" {
  description = "GitHub organisation name."
  type        = string
}

variable "github_repositories" {
  description = "List of GitHub repository names."
  type        = list(string)
}

variable "iam_role_name" {
  description = "Friendly name of the role. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = "GitHubOIDCRole"
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = "IAM role to enable GitHub OIDC access"
}

variable "max_session_duration" {
  default     = 3600
  description = "Maximum session duration in seconds."
  type        = number
}

variable "iam_role_path" {
  default     = "/"
  description = "Path to the IAM role."
  type        = string
}

variable "iam_default_policy_arn" {
  description = "ARN of IAM Default Policies managed by AWS"
  type        = list(string)
  default     = []
}

variable "iam_custom_policy" {
  description = "Custom Policy of IAM Role"
  default     = null
  type = object({
    template = optional(string, null)
  })
}
