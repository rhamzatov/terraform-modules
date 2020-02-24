output "arn" {
  value       = aws_kinesis_firehose_delivery_stream.app.id
  description = "The Amazon Resource Name (ARN) specifying the Stream"
}

