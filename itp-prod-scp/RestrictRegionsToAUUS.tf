# ---------------------------------------- # 
# Service Control Policies for all accounts
# ---------------------------------------- #



# ---------------------------- #
# REGION RESTRICTION 
# ---------------------------- #

data "aws_organizations_organization" "org" {}

data "aws_iam_policy_document" "restrict-regions-to-au-us" {
  statement {
    sid       = "RegionRestriction"
    actions   = ["*"]
    resources = ["*"]
    effect    = "Deny"

    condition {
      test     = "StringNotLike"
      variable = "aws:RequestedRegion"

      values = [
        "ap-southeast-2",
        "ap-southeast-4",
        "us-east-1"
      ]
    }
  }
}

resource "aws_organizations_policy" "RestrictRegionsExceptAU" {
  name        = "deny_regions_except_au_us"
  description = "Deny all regions except AU and US East 1"
  content     = data.aws_iam_policy_document.restrict-regions-to-au-us.json
}

#Organization Account
#resource "aws_organizations_policy_attachment" "account" {
# policy_id = aws_organizations_policy.example.id
#target_id = "123456789012"
#}
#Organization Root
#resource "aws_organizations_policy_attachment" "root" {
# policy_id = aws_organizations_policy.example.id
#target_id = aws_organizations_organization.example.roots[0].id
#}
#Organization Unit
#resource "aws_organizations_policy_attachment" "unit" {
# policy_id = aws_organizations_policy.example.id
#target_id = aws_organizations_organizational_unit.example.id
#}

