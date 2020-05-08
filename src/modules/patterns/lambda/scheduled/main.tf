module "lambda" {
  source         = "../with_cw_logs"
  name           = var.name
  description    = var.description
  s3_bucket_name = var.s3_bucket_name
  s3_bucket_path = var.s3_bucket_path
  handler        = var.handler
  runtime        = var.runtime
  memory_size    = var.memory_size
  timeout        = var.timeout
  variables      = var.variables
  vpc_config     = var.vpc_config

  log_retention_days = var.log_retention_days

  max_concurrent_executions = var.max_concurrent_executions

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "schedule" {
  name                = var.name
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "schedule_target" {
  rule = aws_cloudwatch_event_rule.schedule.name
  arn  = module.lambda.lambda_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule.arn
}

