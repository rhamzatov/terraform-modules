module "queue" {
  source                     = "../sqs_with_dlq"
  name                       = "${var.name}"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  message_retention_seconds  = "${var.message_retention_seconds}"
  max_message_size           = "${var.max_message_size}"
  delay_seconds              = "${var.delay_seconds}"
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"
  max_receive_count          = "${var.max_receive_count}"
  policy                     = "${var.policy}"
  tags                       = "${var.tags}"
}

module "topic" {
  source = "../../resources/sns/plain"
  name   = "${var.name}"
  tags   = "${var.tags}"
}

resource "aws_sns_topic_subscription" "topic_subscription" {
  topic_arn = "${module.topic.arn}"
  protocol  = "sqs"
  endpoint  = "${module.queue.arn}"
}

data "aws_iam_policy_document" "send_policy" {
  statement {
    principals = [
      {
        type        = "AWS"
        identifiers = ["*"]
      },
    ]

    actions = [
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:SendMessage",
    ]

    resources = ["${module.queue.arn}"]
  }
}

resource "aws_sqs_queue_policy" "send_policy" {
  queue_url = "${module.queue.url}"
  policy    = "${data.aws_iam_policy_document.send_policy.json}"
}
