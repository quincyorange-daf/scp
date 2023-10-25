resource "aws_organizations_policy" "tags_appregid" {
  name = "tags_appregid"
  type = TAG_POLICY
  content = <<CONTENT
{
    "tags": {
        "APPREGID": {
            "tag_key": {
                "@@assign": "APPREGID"
            },
            "tag_value": {
                "@@assign": [
                    "APPREG****",
                    "APPREG0000"
                ]
            },
            "enforced_for": {
                "@@assign": [
                    "EC2:*"
                ]
            }
        }
    }
}
CONTENT
}