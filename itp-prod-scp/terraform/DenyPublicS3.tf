# ***** Deny access to leave the organization *****
data "aws_iam_policy_document" "PreventPublicS3Bucket" {
  statement {
    sid    = "PreventPublicS3Bucket"
    effect = "Deny"
    actions = [
      "s3:PutBucketPublicAccessBlock",
      "s3:PutAccountPublicAccessBlock"
    ]
    resources = ["*"]
  }
}


# Create the policy and attach the policy rules
resource "aws_organizations_policy" "PreventPublicS3Bucket" {
  name        = "PreventPublicS3Bucket"
  description = "Prevent public S3 bucket creation."
  content     = data.aws_iam_policy_document.PreventPublicS3Bucket.json
}