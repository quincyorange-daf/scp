# ***** Deny access to create Internet Gateways *****
data "aws_iam_policy_document" "DenyInternetAccess" {
  statement {
    sid    = "DenyInternetAccess"
    effect = "Deny"
    actions = [
      "ec2:AttachInternetGateway",
      "ec2:CreateInternetGateway",
      "ec2:CreateEgressOnlyInternetGateway",
      "ec2:CreateVpcPeeringConnection",
      "ec2:AcceptVpcPeeringConnection",
      "globalaccelerator:Create*",
      "globalaccelerator:Update*"
    ]
    resources = ["*"]

    condition {
      test     = "StringNotLike"
      variable = "aws:PrincipalARN"

      values = [
        "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/ap-southeast-2/AWSReservedSSO_ITPManaged-SecurityManagement*",
        "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/ap-southeast-2/AWSReservedSSO_HybridCloud*"
      ]
    }
  }
}

# Create the policy and attach the policy rules
resource "aws_organizations_policy" "DenyIGW" {
  name        = "DenyIGW"
  description = "Deny Internet Gateway creation."
  content     = data.aws_iam_policy_document.DenyInternetAccess.json
}
