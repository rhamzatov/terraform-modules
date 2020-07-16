module "dlq" {
  source                     = "../../resources/sqs/plain"
  name                       = "${var.name}${var.dlq_suffix}"
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

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [module.queue.arn]
  }
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = module.queue.id
  policy    = data.aws_iam_policy_document.queue_policy.json
}

