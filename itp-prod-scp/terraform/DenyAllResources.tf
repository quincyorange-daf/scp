#**** Deny acces to create any resources policy *****

data "aws_iam_policy_document" "deny_all_resources" {
  statement {
    sid       = "DenyAllResources"
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
  }
}

#### create the policy and attach the policy rules ########

resource "aws_organizations_policy" "DenyAllResources" {
  name        = "deny_all_resources"
  description = "deny_all_resources"
  content     = data.aws_iam_policy_document.deny_all_resources.json
}

#### To attach policy to Organization Account ########
# resource "aws_organizations_policy_attachment" "deny_all_resources" {
#  policy_id = aws_organizations_policy.deny_all_resources.id  ## (Required) The unique identifier (ID) of the policy that you want to attach to the target.
# target_id = "ou-g"  ## (Required) The unique identifier (ID) organizational unit, you want to attach the policy to.
# }

