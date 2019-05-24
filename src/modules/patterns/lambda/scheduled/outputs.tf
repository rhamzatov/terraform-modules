output "lambda_arn" {
  value = "${module.lambda.lambda_arn}"
}

output "role_arn" {
  value = "${module.lambda.role_arn}"
}

output "role_name" {
  value = "${module.lambda.role_name}"
}
