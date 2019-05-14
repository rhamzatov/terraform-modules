output "id" {
  value       = "${aws_sqs_queue.queue.id}"
  description = "The URL for the created Amazon SQS queue."
}

output "arn" {
  value       = "${aws_sqs_queue.queue.arn}"
  description = "The ARN of the SQS queue"
}
