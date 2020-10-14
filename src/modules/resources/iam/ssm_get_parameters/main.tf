terraform {
  required_version = ">= 0.12"
}

data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "app" {
  name        = var.policy_name
  description = "Grant read access to Paramerer Store"
  policy      = data.aws_iam_policy_document.app.json
}
