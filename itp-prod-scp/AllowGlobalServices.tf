data "aws_iam_policy_document" "allow-global-services" {
  statement {
    sid = "AllowGlobalServices"
    not_actions = ["a4b:*",
      "acm:*",
      "aws-marketplace-management:*",
      "aws-marketplace:*",
      "aws-portal:*",
      "awsbillingconsole:*",
      "account:GetAccountInformation",
      "budgets:*",
      "billing:*",
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
      "invoicing:*",
      "kms:*",
      "networkmanager:*",
      "organizations:*",
      "pricing:*",
      "payments:*",
      "purchase-orders:*",
      "tax:*",
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
      test     = "StringLike"
      variable = "aws:RequestedRegion"

      values = [
        "us-east-1"
      ]
    }
  }
}

resource "aws_organizations_policy" "AllowGlobalServices" {
  name        = "AllowGlobalServices"
  description = "Allow global services in us-east-1"
  content     = data.aws_iam_policy_document.allow-global-services.json
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
#
