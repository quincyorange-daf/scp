# ---------------------------------------- #
# Service Control Policies for all accounts
# ---------------------------------------- #
resource "aws_organizations_policy" "allow_all_policy" {
  name        = "allow_all_policy"
  description = "Allow all actions"
  content = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOT
}

# ---------------------------------------- #
# REGION RESTRICTIONS
# ---------------------------------------- #

data "aws_iam_policy_document" "restrict_regions" {
  statement {
    sid       = "RegionRestriction"
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values = ["ap-southeast-2", "ap-southeast-4", "us-east-1"]
    }
  }
}

resource "aws_organizations_policy" "restrict_regions" {
  name        = "restrict_regions"
  description = "Deny all regions except ap-southeast-2"
  content     = data.aws_iam_policy_document.restrict_regions.json
}

data "aws_organizations_organizational_unit" "aft_test_ou" {
  name = "aft-test"
}

resource "aws_organizations_policy_attachment" "restrict_regions_on_ou" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = data.aws_organizations_organizational_unit.aft_test_ou.id
}
