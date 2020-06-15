terraform {
  required_version = ">= 0.12"
}

module "dlq" {
  source                     = "../../resources/sqs/plain"
  name                       = "${var.name}-ERROR"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  tags                       = var.tags

  message_retention_seconds = 1209600 # Max
  max_message_size          = 262144  # Max
}

module "queue" {
  source                     = "../../resources/sqs/plain"
  name                       = var.name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  redrive_policy             = "{\"deadLetterTargetArn\":\"${module.dlq.arn}\",\"maxReceiveCount\":${var.max_receive_count}}"
  policy                     = var.policy
  tags                       = var.tags
}

data "aws_iam_policy_document" "queue_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:SendMessage",
    ]

    resources = [module.queue.arn]
  }
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = module.queue.id
  policy    = data.aws_iam_policy_document.queue_policy.json
}
