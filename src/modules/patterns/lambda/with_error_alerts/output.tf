output "lambda_arn" {
  value = "${module.lambda.lambda_arn}"
}

output "lambda_invoke_arn" {
  value = "${module.lambda.lambda_invoke_arn}"
}

output "role_arn" {
  value = "${module.lambda.role_arn}"
}

output "role_name" {
  value = "${module.lambda.role_name}"
}

output "log_group_name" {
  value = "${module.lambda.log_group_name}"
}
