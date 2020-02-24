resource "aws_sqs_queue" "queue" {
  name                        = "${var.name}.fifo"
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = var.message_retention_seconds
  max_message_size            = var.max_message_size
  delay_seconds               = var.delay_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  policy                      = var.policy
  fifo_queue                  = true
  content_based_deduplication = var.content_based_deduplication
  tags                        = var.tags
}

