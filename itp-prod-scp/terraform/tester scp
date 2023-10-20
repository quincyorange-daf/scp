# ---------------------------------------- # 
# Service Control Policies for all accounts
# ---------------------------------------- #

# ---------------------------- #
# ALLOW ALL
# ---------------------------- #
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
},

# ---------------------------------------- # 
# Service Control Policies for all accounts
# ---------------------------------------- #

# ---------------------------- #
# REGION RESTRICTIONS
# ---------------------------- #

data "aws_iam_policy_document" "restrict_regions" {
  statement {
    sid       = "RegionRestriction"
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"

      values = [
        "ap-southeast-2",
        "ap-southeast-4",
        "US-east-1"
      ]
    }
  }
}

resource "aws_organizations_policy" "restrict_regions" {
  name        = "restrict_regions"
  description = "Deny all regions except ap-southeast-2"
  content     = data.aws_iam_policy_document.restrict_regions.json
}

resource "aws_organizations_policy_attachment" "restrict_regions_on_root" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = aws_organizations_organization.this.roots[0].id
}
