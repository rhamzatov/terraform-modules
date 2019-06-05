module "lambda" {
  source         = "../with_cw_logs"
  name           = "${var.name}"
  description    = "${var.description}"
  s3_bucket_name = "${var.s3_bucket_name}"
  s3_bucket_path = "${var.s3_bucket_path}"
  handler        = "${var.handler}"
  runtime        = "${var.runtime}"
  memory_size    = "${var.memory_size}"
  timeout        = "${var.timeout}"
  variables      = "${var.variables}"

  log_retention_days = "${var.log_retention_days}"

  max_concurrent_executions = -1

  tags = "${var.tags}"
}

module "api" {
  source = "../../api_gateway/all_path"

  name               = "${var.name}"
  sub_domain         = "${var.sub_domain}"
  domain_certificate = "${var.domain_certificate}"
  lambda_invoke_arn  = "${module.lambda.lambda_invoke_arn}"
}

resource "aws_lambda_permission" "app" {
  depends_on = ["module.lambda"]

  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${module.api.execution_arn}/*/*/*"
}
