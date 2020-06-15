terraform {
  required_version = ">= 0.12"
}

module "queue" {
  source                     = "../sqs_with_dlq"
  name                       = var.name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  max_receive_count          = var.max_receive_count
  policy                     = var.policy
  tags                       = var.tags
}

module "topic" {
  source = "../../resources/sns/plain"
  name   = var.name
  tags   = var.tags
}

resource "aws_sns_topic_subscription" "topic_subscription" {
  topic_arn = module.topic.arn
  protocol  = "sqs"
  endpoint  = module.queue.arn
  
  raw_message_delivery = true
}

