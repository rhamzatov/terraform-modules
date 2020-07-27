terraform {
  required_version = ">= 0.12"
}

locals {
  resolve_s3_key = var.filepath == null ? local.resolve_bucket_path : null
}

locals {
  resolve_bucket_path = var.s3_bucket_path == null ? "builds/lambda/${var.name}/lambda.zip" : var.s3_bucket_path

  vpc_config = var.vpc_config == null ? [] : toset([var.vpc_config])
}

resource "aws_lambda_function" "app" {
  function_name = var.name
  description   = var.description
  role          = var.role_arn
  s3_bucket     = var.s3_bucket_name
  s3_key        = local.resolve_s3_key
  filename      = var.filepath
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout

  reserved_concurrent_executions = var.max_concurrent_executions

  dynamic "vpc_config" {
    for_each = local.vpc_config

    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  environment {
    variables = var.variables
  }

  tags = var.tags
}

