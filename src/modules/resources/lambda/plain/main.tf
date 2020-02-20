resource "aws_lambda_function" "app" {
  function_name = "${var.name}"
  description   = "${var.description}"
  role          = "${var.role_arn}"
  s3_bucket     = "${var.s3_bucket_name}"
  s3_key        = "${var.s3_bucket_path == "" ? "builds/lambda/${var.name}/lambda.zip" : var.s3_bucket_path }"
  filename      = "${var.filepath}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"

  reserved_concurrent_executions = "${var.max_concurrent_executions}"

  environment {
    variables = "${var.variables}"
  }

  tags = "${var.tags}"
}
