#**** deny access for the account to leave the ITP organisation *******

data "aws_iam_policy_document" "PreventLeavingAWSOrganization" {
  statement {
    sid       = "PreventLeavingAWSOrganization"
    effect    = "Deny"
    actions   = ["organizations:LeaveOrganization"]
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




#### create the policy and attach the policy rules ########
resource "aws_organizations_policy" "deny_igw_org" {
  name        = "DenyIGWOrg"
  description = "Deny the account from leaving the Organisation"
  content = [
    data.aws_iam_policy_document.PreventLeavingAWSOrganization.json
  ]
}
