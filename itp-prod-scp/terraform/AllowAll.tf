data "aws_iam_policy_document" "allow_all_access" {

  statement {
    sid       = "AllowAllAccess"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "AllowAll" {
  name        = "AllowAllResources"
  description = "Allow all resources"
  content     = data.aws_iam_policy_document.allow_all_access.json
}
