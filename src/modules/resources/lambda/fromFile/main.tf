resource "aws_lambda_function" "app" {
  count         = "${var.count}"
  function_name = "${var.name}"
  description   = "${var.description}"
  role          = "${var.role_arn}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  filename      = "${var.filepath}"

  reserved_concurrent_executions = "${var.max_concurrent_executions}"

  environment {
    variables = "${var.variables}"
  }

  tags = "${var.tags}"
}
