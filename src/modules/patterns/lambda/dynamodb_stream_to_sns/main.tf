locals {
  sourceFile = "${path.module}/index.js"
}

module "dlq" {
  source                    = "../../../resources/sqs/plain"
  name                      = "${var.name}-${var.dlq_suffix}"
  message_retention_seconds = 1209600                        # Max
  max_message_size          = 262144                         # Max
  tags                      = "${var.tags}"
}

module "sns_publisher_policy" {
  source      = "../../../resources/iam/sns_publisher"
  policy_name = "${var.name}-SNS"
  topics_arn  = ["${var.topic_arn}"]
}

module "dlq_publisher_policy" {
  source      = "../../../resources/iam/sqs_publisher"
  policy_name = "${var.name}-DLQ"
  queues_arn  = ["${module.dlq.arn}"]
}

module "stream_policy" {
  source      = "../../../resources/iam/dynamodb_stream"
  policy_name = "${var.name}-Stream"
  stream_arn  = "${var.event_source_arn}"
}

resource "aws_iam_role_policy_attachment" "sns_policy_attachment" {
  role       = "${module.app.role_name}"
  policy_arn = "${module.sns_publisher_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "dlq_policy_attachment" {
  role       = "${module.app.role_name}"
  policy_arn = "${module.dlq_publisher_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role       = "${module.app.role_name}"
  policy_arn = "${module.stream_policy.arn}"
}

module "app" {
  source       = "../with_error_alerts"
  name         = "${var.name}"
  filepath     = "${local.sourceFile}"
  handler      = "index.handler"
  runtime      = "nodejs10.x"
  emails       = "${var.emails}"
  description  = "${var.description}"
  tags         = "${var.tags}"
  memory_size  = 512
  alert_period = "${var.alert_period}"

  variables = {
    SUBJECT   = "${var.subject}"
    TOPIC_ARN = "${var.topic_arn}"
    DLQ_URL   = "${module.dlq.id}"
  }
}

resource "aws_lambda_event_source_mapping" "app" {
  function_name     = "${module.app.lambda_arn}"
  event_source_arn  = "${var.event_source_arn}"
  batch_size        = "${var.batch_size}"
  starting_position = "TRIM_HORIZON"
}
