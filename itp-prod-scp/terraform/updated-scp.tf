# ---------------------------------------- # 
# Service Control Policies for all accounts
# ---------------------------------------- #

# ---------------------------- #
# REGION RESTRICTION 
# ---------------------------- #

data "aws_iam_policy_document" "restrict_regions" {
  statement {
    sid       = "RegionRestriction"
    actions   = ["*"]
    resources = ["*"]
    effect    = "Deny"
    not_actions = [
        "a4b:*",
        "acm:*",
        "aws-marketplace-management:*",
        "aws-marketplace:*",
        "aws-portal:*",
        "awsbillingconsole:*",
        "budgets:*",
        "ce:*",
        "chime:*",
        "cloudfront:*",
        "cloudtrail:*",
        "config:*",
         "cur:*",
        "directconnect:*",
        "ec2:DescribeRegions",
       "ec2:DescribeTransitGateways",
       "ec2:DescribeVpnGateways",
        "fms:*",
        "globalaccelerator:*",
        "health:*",
        "iam:*",
        "importexport:*",
        "kms:*",
         "networkmanager:*",
        "organizations:*",
        "pricing:*",
        "route53:*",
        "route53domains:*",
        "s3:*",
        "s3:GetAccountPublic*",
        "s3:ListAllMyBuckets",
        "s3:PutAccountPublic*",
        "shield:*",
        "sts:*",
        "support:*",
        "trustedadvisor:*",
        "waf-regional:*",
        "waf:*",
        "wafv2:*",
        "wellarchitected:*"]


    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"

      values = [
        "ap-southeast-2",
        "ap-southeast-4"
      ]
    }
  }
}

resource "aws_organizations_policy" "restrict_regions" {
  name        = "allow_global_regions"
  description = "Deny all regions except US East 1."
  content     = data.aws_iam_policy_document.restrict_regions.json
}

resource "aws_organizations_policy_attachment" "restrict_regions_on_root" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = var.target_id_client
}

# ---------------------------- #
# REQUIRE EC2 TAGS 
# ---------------------------- #

data "aws_iam_policy_document" "require_ec2_tags" {
  statement {
    sid    = "RequireTag"
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
      variable = "aws:RequestTag/Name"

      values = ["true"]
    }
  }
}

resource "aws_organizations_policy" "require_ec2_tags" {
  name        = "require_ec2_tags"
  description = "Name tag is required for EC2 instances and volumes."
  content     = data.aws_iam_policy_document.require_ec2_tags.json
}

resource "aws_organizations_policy_attachment" "require_ec2_tags" {
  policy_id = aws_organizations_policy.require_ec2_tags.id
  target_id = var.target_id_client
}