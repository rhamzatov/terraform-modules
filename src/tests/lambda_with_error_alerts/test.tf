provider "aws" {
  region = "eu-west-1"
}

locals {
  app_name = "test-lambda-with-error-alerts"
  bucket   = "cct-bo-temp-t"
}

module "label" {
  source      = "../../modules/resources/label"
  application = local.app_name
  name        = "app"
  environment = "test"
  domain      = "ci-cd platform"
  cost_center = "3600"
  team        = "customer care technology"
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.cwd}/publish/index.zip"
}

resource "aws_s3_bucket_object" "bucket" {
  key    = local.app_name
  bucket = local.bucket
  source = "${path.cwd}/publish/index.zip"
}

module "test" {
  source         = "../../modules/patterns/lambda/with_error_alerts"
  name           = local.app_name
  emails         = ["salavat.galiamov@albelli.com"]
  tags           = module.label.tags
  s3_bucket_name = local.bucket
  s3_bucket_path = aws_s3_bucket_object.bucket.id
  filepath       = ""
  handler        = "index.handler"
  runtime        = "nodejs10.x"
  alert_period   = 60
}

