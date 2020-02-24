data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "sqs:GetQueueUrl",
      "sqs:GetQueueAttributes",
      "sqs:ListQueueTags",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ReceiveMessage",
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
    ]

    resources = var.queues_arn
  }
}

resource "aws_iam_policy" "app" {
  name        = var.policy_name
  description = "Allows read messages from specific queue(s)"
  policy      = data.aws_iam_policy_document.app.json
}

