output "url" {
  value       = "${module.queue.id}"
  description = "The URL for the created SQS queue."
}

output "arn" {
  value       = "${module.queue.arn}"
  description = "The ARN of the SQS queue"
}

output "dlq_url" {
  value       = "${module.dlq.id}"
  description = "The URL for the created DLQ SQS queue."
}

output "dlq_arn" {
  value       = "${module.dlq.arn}"
  description = "The ARN of the DLQ SQS queue"
}
