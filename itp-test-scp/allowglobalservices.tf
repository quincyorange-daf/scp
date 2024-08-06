terraform {
  required_version = ">= 1.7.0, < 2.0.0"
}

data "aws_iam_policy_document" "allow-global-services-outside-aus" {
  statement {
    sid       = "AllowGlobalServicesOutsideAus"
    effect    = "Deny"
    actions   = ["*"]
    not_actions = [
      "a4b:*",
      "access-analyzer:*",
      "account:*",
      "acm:*",
      "activate:*",
      "artifact:*",
      "aws-marketplace-management:*",
      "aws-marketplace:*",
      "aws-portal:*",
      "billing:*",
      "billingconductor:*",
      "budgets:*",
      "ce:*",
      "chatbot:*",
      "chime:*",
      "cloudfront:*",
      "cloudtrail:LookupEvents",
      "compute-optimizer:*",
      "config:*",
      "consoleapp:*",
      "consolidatedbilling:*",
      "cur:*",
      "datapipeline:GetAccountLimits",
      "devicefarm:*",
      "directconnect:*",
      "ec2:DescribeRegions",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeVpnGateways",
      "ecr-public:*",
      "fms:*",
      "freetier:*",
      "globalaccelerator:*",
      "health:*",
      "iam:*",
      "importexport:*",
      "invoicing:*",
      "iq:*",
      "kms:*",
      "license-manager:ListReceivedLicenses",
      "lightsail:Get*",
      "mobileanalytics:*",
      "networkmanager:*",
      "notifications-contacts:*",
      "notifications:*",
      "organizations:*",
      "payments:*",
      "pricing:*",
      "quicksight:DescribeAccountSubscription",
      "resource-explorer-2:*",
      "route53-recovery-cluster:*",
      "route53-recovery-control-config:*",
      "route53-recovery-readiness:*",
      "route53:*",
      "route53domains:*",
      "s3:CreateMultiRegionAccessPoint",
      "s3:DeleteMultiRegionAccessPoint",
      "s3:DescribeMultiRegionAccessPointOperation",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetMultiRegionAccessPoint",
      "s3:GetMultiRegionAccessPointPolicy",
      "s3:GetMultiRegionAccessPointPolicyStatus",
      "s3:GetStorageLensConfiguration",
      "s3:GetStorageLensDashboard",
      "s3:ListAllMyBuckets",
      "s3:ListMultiRegionAccessPoints",
      "s3:ListStorageLensConfigurations",
      "s3:PutAccountPublicAccessBlock",
      "s3:PutMultiRegionAccessPointPolicy",
      "savingsplans:*",
      "shield:*",
      "sso:*",
      "sts:*",
      "support:*",
      "supportapp:*",
      "supportplans:*",
      "sustainability:*",
      "tag:GetResources",
      "tax:*",
      "trustedadvisor:*",
      "vendor-insights:ListEntitledSecurityProfiles",
      "waf-regional:*",
      "waf:*",
      "wafv2:*"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values   = ["ap-southeast-2", "ap-southeast-4"]
    }
    condition {
      test     = "ArnNotLike"
      variable = "aws:PrincipalARN"
      values   = [
        "arn:*:iam::*:role/AWSControlTowerExecution",
        "arn:*:iam::*:role/aws-controltower-ConfigRecorderRole",
        "arn:*:iam::*:role/aws-controltower-ForwardSnsNotificationRole",
        "arn:*:iam::*:role/AWSControlTower_VPCFlowLogsRole"
      ]
    }
  }
}

resource "aws_organizations_policy" "allow-global-services-outside-aus-policy" {
  name        = "AllowGlobalServicesOutsideAus"
  description = "Allow global services in non-Australian regions"
  content     = data.aws_iam_policy_document.allow-global-services-outside-aus.json
  type        = "SERVICE_CONTROL_POLICY"
}


