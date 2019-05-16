output "name" {
  value       = "${aws_s3_bucket.app.id}"
  description = "The name of the bucket."
}

output "arn" {
  value       = "${aws_s3_bucket.app.arn}"
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
}
