
#***** deny access to create public facing S3 buckets *******
data "aws_iam_policy_document" "denyS3logs" {
  statement {
    sid       = "denyS3logs"
    effect    = "Deny"
    actions   = [
                 "s3:DeleteBucket",
                 "s3:DeleteObject",
                 "s3:DeleteObjectVersion"
                 ]
    resources = [
                 "arn:aws:s3:::bcp-itp-production-accounts-cloudtrail",
                 "arn:aws:s3:::bcp-itp-production-accounts-cloudtrail-temp",
                 "arn:aws:s3:::bcp-itp-production-accounts-config",
                 "arn:aws:s3:::bcp-itp-production-accounts-guardduty",
                 "arn:aws:s3:::bcp-itp-production-accounts-serverproxy",
                 "arn:aws:s3:::bcp-itp-production-accounts-vpcflowlogs",
                 "arn:aws:s3:::bcp-itp-production-accounts-waf",
                 "arn:aws:s3:::bcp-itp-queryresults",
                 "arn:aws:s3:::itp-centralised-cloudtrail-global",
                 "arn:aws:s3:::itp-centralised-cloudtrail-splunk",
                 "arn:aws:s3:::itp-centralised-logs",
                 "arn:aws:s3:::itp-daf-accounts-accesslogs",
                 "arn:aws:s3:::itp-daf-accounts-config",
                 "arn:aws:s3:::itp-daf-accounts-flowlogs",
                 "arn:aws:s3:::itp-daf-accounts-trails"
                 ]
  }
}


#### create the policy and attach the policy rules ########
resource "aws_organizations_policy" "denyS3logs" {
  name        = "DenyS3Logs"
  description = "Allow certain EC2 instance types only."
  content     = data.aws_iam_policy_document.denyS3logs.json
}