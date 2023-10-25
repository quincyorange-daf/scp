resource "aws_organizations_policy" "TagsAppregid" {
  name = "TagsAppregid"
  type = "TAG_POLICY"
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