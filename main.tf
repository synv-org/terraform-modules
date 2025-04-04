resource "aws_iam_openid_connect_provider" "github" {
  url             = var.oidc_url
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list
}

resource "aws_iam_role" "github" {
  name                 = var.iam_role_name
  description          = var.iam_role_description
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path
}

#IAM Default Policy
resource "aws_iam_role_policy_attachment" "github" {
  count = length(var.iam_default_policy_arn)

  role       = aws_iam_role.github.name
  policy_arn = element(var.iam_default_policy_arn, count.index)
}

#IAM Custom Policy
resource "aws_iam_role_policy" "github" {
  count = var.iam_custom_policy != null ? 1 : 0

  name   = "${var.iam_role_name}-policy"
  role   = aws_iam_role.github.id
  policy = var.iam_custom_policy.template
}
