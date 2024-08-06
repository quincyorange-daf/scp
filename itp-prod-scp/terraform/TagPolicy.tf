terraform {
  required_version = ">= 1.7.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_iam_policy_document" "require_appreg_tags" {
  statement {
    sid    = "RequireAppregTag"
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume",
      "events:PutTargets",
      "ec2:CreateNetworkInterface",
      "ec2:CreateCarrierGateway",
      "ec2:CreateCustomerGateway",
      "ec2:CreateDefaultSubnet",
      "ec2:CreateDefaultVpc",
      "ec2:CreateDhcpOptions",
      "ec2:CreateEgressOnlyInternetGateway",
      "ec2:CreateFlowLogs",
      "ec2:CreateInternetGateway",
      "ec2:CreateLocalGatewayRouteTableVpcAssociation",
      "ec2:CreateNatGateway",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:CreateVpcEndpoint",
      "ec2:CreateVpcEndpointConnectionNotification",
      "ec2:CreateVpcEndpointServiceConfiguration",
      "ec2:CreateVpcPeeringConnection",
      "ec2:CreateVpnConnection",
      "ec2:CreateVpnConnectionRoute",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
    ]
    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/APPREGID"

      values = ["true"]
    }
  }
}

resource "aws_organizations_policy" "require_appreg_tags" {
  name        = "require_appreg_tags"
  description = "APPREGID tag is required for EC2 instances and volumes."
  content     = data.aws_iam_policy_document.require_appreg_tags.json
}
