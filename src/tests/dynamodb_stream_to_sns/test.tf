provider "aws" {
  region = "eu-west-1"
}

locals {
  name = "test-dynamo-to-sqs"
}

module "label" {
  source      = "../../modules/resources/label"
  application = local.name
  name        = "app"
  environment = "test"
  domain      = "ci-cd platform"
  cost_center = "3600"
  team        = "customer care technology"
}

resource "aws_dynamodb_table" "table" {
  name             = local.name
  hash_key         = "Id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "Id"
    type = "S"
  }
}

module "sns_to_sqs" {
  source = "../../modules/patterns/sns_to_sqs_with_dlq"
  name   = "${local.name}-Output"
  tags   = module.label.tags
}

module "test" {
  source           = "../../modules/patterns/lambda/dynamodb_stream_to_sns"
  name             = local.name
  event_source_arn = aws_dynamodb_table.table.stream_arn
  topic_arn        = module.sns_to_sqs.sns_arn
  emails           = ["ruslan.hamzatov@albelli.com"]
  alert_period     = 60

  batch_size                     = 1000
  parallelization_factor         = 10
  maximum_retry_attempts         = 15
  bisect_batch_on_function_error = true

  tags = module.label.tags
}

