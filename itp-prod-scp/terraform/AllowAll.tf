
data "aws_iam_policy_document" "AllowAllRecources" {
  statement {
    sid = "AllowAllResources"
    actions = ["*"]
    resources = ["*"]
    effect = "Allow"
   
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["ap-southeast-2", "ap-southeast-4"]
    }
  }
}

resource "aws_organizations_policy" "AllowAll" {
  name        = "AllowAllResources"
  description = "Allow all resources in ap-southeast-2 and 4"
  content     = data.aws_iam_policy_document.AllowAllResources.json
}
