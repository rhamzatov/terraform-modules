module "dlq" {
  source                     = "../../resources/sqs/plain"
  name                       = "${var.name}-ERROR"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  message_retention_seconds  = 1209600
  max_message_size           = 262144
  tags                       = "${var.tags}"
}

module "queue" {
  source                     = "../../resources/sqs/plain"
  name                       = "${var.name}"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  message_retention_seconds  = "${var.message_retention_seconds}"
  max_message_size           = "${var.max_message_size}"
  delay_seconds              = "${var.delay_seconds}"
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"
  redrive_policy             = "{\"deadLetterTargetArn\":\"${module.dlq.arn}\",\"maxReceiveCount\":${var.max_receive_count}}"
  policy                     = "${var.policy}"
  tags                       = "${var.tags}"
}
