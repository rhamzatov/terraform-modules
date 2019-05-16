data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "sqs:GetQueueUrl",
      "sqs:GetQueueAttributes",
      "sqs:ListQueueTags",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:SendMessageBatch",
      "sqs:SendMessage",
      "sqs:SetQueueAttributes",
    ]

    resources = ["${var.queues_arn}"]
  }
}

resource "aws_iam_policy" "app" {
  name        = "${var.policy_name}"
  description = "Allows write messages to specific queue(s)"
  policy      = "${data.aws_iam_policy_document.app.json}"
}
