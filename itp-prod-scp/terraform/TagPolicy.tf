
data "aws_iam_policy_document" "require_appreg_tags" {
  statement {
    sid    = "RequireAppregTag"
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ec2:*:*:volume/*"
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/APPREGID"

      values = ["true"]
    }
  }
}

resource "aws_organizations_policy" "require_appreg_tags" {
  name        = "require_appreg_tags"
  description = "APPREGID tag is required for EC2 instances and volumes."
  content     = data.aws_iam_policy_document.require_ec2_tags.json
}
