locals {
  APPREGID = "^APPREG\\d{4}$" # Match "APPREG" followed by exactly four digits
}

data "aws_iam_policy_document" "appreg_tags" {
  statement {
    sid    = "RequireAppregTag"
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume"
    ]
    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/APPREGID"

      values = [local.APPREGID] # Wrap in a list
    }
  }
}

resource "aws_organizations_policy" "appregid_tag" {
  name        = "appregid_tag"
  description = "APPREGID tag is required for all resources"
  content     = data.aws_iam_policy_document.appreg_tags.json
}