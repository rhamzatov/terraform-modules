output "lambda_arn" {
  value = "${module.lambda.arn}"
}

output "role_arn" {
  value = "${aws_iam_role.app.arn}"
}

output "role_name" {
  value = "${aws_iam_role.app.name}"
}
