output "arn" {
  value = "${aws_lambda_function.app.arn}"
}

output "qualified_arn" {
  value = "${aws_lambda_function.app.qualified_arn}"
}

output "invoke_arn" {
  value = "${aws_lambda_function.app.invoke_arn}"
}
