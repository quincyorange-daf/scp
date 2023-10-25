# ---------------------------------------- # 
# Service Control Policies for all accounts
# ---------------------------------------- #



# ---------------------------- #
# REGION RESTRICTION 
# ---------------------------- #

data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

data "aws_iam_policy_document" "restrict-regions" {
  statement {
    sid = "RegionRestriction"
    not_actions = ["a4b:*",
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
    resources = ["*"]
    effect    = "Deny"
   
  condition {
    test     = "StringNotEqualsIgnoreCase"
    variable = "aws:RequestedRegion"

    values = [
        "ap-southeast-2",
        "ap-southeast-4"
      ]
    }
  }
}

resource "aws_organizations_policy" "RestrictRegions" {
  name        = "allow_global_regions"
  description = "Deny all regions except US East 1"
  content     = data.aws_iam_policy_document.restrict-regions.json
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
      variable = ["aws:RequestTag/APPREGID"]

      values = ["APPREG****","APPREG0000"]
    }
  }
}

resource "aws_organizations_policy" "require_ec2_tags" {
  name        = "require_ec2_tags"
  description = "Name tag is required for EC2 instances and volumes."
  content     = data.aws_iam_policy_document.require_ec2_tags.json
}

