resource "aws_kinesis_firehose_delivery_stream" "app" {
  name        = var.name
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn        = var.role_arn
    bucket_arn      = var.bucket_arn
    buffer_interval = var.buffer_interval_in_seconds
    buffer_size     = var.buffer_size_in_mb
  }

  tags = var.tags
}

