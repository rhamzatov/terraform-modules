data "aws_caller_identity" "current" {}

locals {
  current_account_as_list = ["${data.aws_caller_identity.current.account_id}"]
}

data "aws_iam_policy_document" "app" {
  statement {
    sid       = "__default_statement_ID_1"
    resources = ["${var.topic_arn}"]

    actions = [
      "sns:GetTopicAttributes",
      "sns:SetTopicAttributes",
      "sns:AddPermission",
      "sns:RemovePermission",
      "sns:DeleteTopic",
      "sns:Subscribe",
      "sns:ListSubscriptionsByTopic",
      "sns:Publish",
      "sns:Receive",
    ]

    principals = [{
      type        = "AWS"
      identifiers = ["*"]
    }]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${data.aws_caller_identity.current.account_id}",
      ]
    }
  }

  statement {
    sid       = "__default_statement_ID_2"
    resources = ["${var.topic_arn}"]

    actions = [
      "sns:Subscribe",
    ]

    principals = [{
      type        = "AWS"
      identifiers = ["${formatlist("arn:aws:iam::%s:root", coalescelist(var.accounts, local.current_account_as_list))}"]
    }]
  }
}

resource "aws_sns_topic_policy" "app" {
  arn    = "${var.topic_arn}"
  policy = "${data.aws_iam_policy_document.app.json}"
}
