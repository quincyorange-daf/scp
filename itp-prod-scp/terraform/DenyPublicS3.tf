# ***** Deny access to leave the organization *****
data "aws_iam_policy_document" "PreventLeaveOrganization" {
  statement {
    sid    = "PreventLeaveOrganization"
    effect = "Deny"
    actions = [
      "organizations:LeaveOrganization"
    ]
    resources = ["*"]

    condition {
      test     = "StringNotLike"
      variable = "aws:PrincipalARN"
      values = [
        "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/ap-southeast-2/AWSReservedSSO_HybridCloud*"
      ]
    }
  }
}

# Create the policy and attach the policy rules
resource "aws_organizations_policy" "deny_leave_organization" {
  name        = "DenyLeaveOrganization"
  description = "Deny leaving the organization."
  content = [
    data.aws_iam_policy_document.PreventLeaveOrganization.json
  ]
}