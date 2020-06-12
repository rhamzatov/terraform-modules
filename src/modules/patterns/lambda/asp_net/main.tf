terraform {
  required_version = ">= 0.12"
}

provider "aws" {}

provider "aws" {
  alias  = "us-east-1"
}

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

  providers = {
    aws = aws
  }
}

module "api" {
  source = "../../api_gateway/all_path"

  name              = var.name
  zone_id           = var.zone_id
  domain            = var.domain
  lambda_invoke_arn = module.lambda.lambda_invoke_arn

  tags = var.tags

  providers = {
    aws = aws
    aws.us-east-1 = aws.us-east-1
  }
}

resource "aws_lambda_permission" "app" {
  depends_on = [module.lambda]

  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${module.api.execution_arn}/*/*/*"
}
