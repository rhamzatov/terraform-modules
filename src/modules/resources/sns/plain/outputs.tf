output "arn" {
  value       = "${aws_sns_topic.app.arn}"
  description = "The ARN of the SNS topic"
}
