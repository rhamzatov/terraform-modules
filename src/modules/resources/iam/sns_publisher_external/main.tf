data "aws_iam_policy_document" "app" {
  statement {
    resources = [var.sns_arn]

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

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.owner_account_id,
      ]
    }

    sid = var.owner_sid
  }

  statement {
    resources = [var.sns_arn]

    actions = [
      "sns:Publish",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.publisher_account_id}:root"]
    }

    sid = var.publisher_sid
  }
}

resource "aws_sns_topic_policy" "app" {
  arn    = var.sns_arn
  policy = data.aws_iam_policy_document.app.json
}

