output "sns_arn" {
  value       = "${module.topic.arn}"
  description = "The ARN of the SNS queue"
}

output "sqs_arn" {
  value       = "${module.queue.arn}"
  description = "The ARN of the SQS queue"
}

output "dlq_arn" {
  value       = "${module.queue.dlq_arn}"
  description = "The ARN of the DLQ"
}
