output "sns_arn" {
  value       = "${module.topic.arn}"
  description = "The ARN of the SNS queue"
}

output "sqs_arn" {
  value       = "${module.queue.arn}"
  description = "The ARN of the SQS queue"
}

output "sqs_url" {
  value       = "${module.queue.url}"
  description = "The URL for the created SQS queue."
}

output "dlq_arn" {
  value       = "${module.queue.dlq_arn}"
  description = "The ARN of the DLQ"
}

output "dlq_url" {
  value       = "${module.queue.dlq_url}"
  description = "The URL for the created DLQ SQS queue."
}
