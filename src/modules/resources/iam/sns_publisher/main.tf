data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "sns:Publish",
    ]

    resources = ["${var.topics_arn}"]
  }
}

resource "aws_iam_policy" "app" {
  name        = "${var.policy_name}"
  description = "Allows publish messages to specific topic(s)"
  policy      = "${data.aws_iam_policy_document.app.json}"
}
