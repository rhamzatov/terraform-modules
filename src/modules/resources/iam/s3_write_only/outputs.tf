output "arn" {
  value       = "${aws_iam_policy.app.arn}"
  description = "The ARN of the IAM policy"
}
