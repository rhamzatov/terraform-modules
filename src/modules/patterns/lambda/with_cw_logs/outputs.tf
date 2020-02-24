output "lambda_arn" {
  value = module.lambda.arn
}

output "lambda_invoke_arn" {
  value = module.lambda.invoke_arn
}

output "role_arn" {
  value = aws_iam_role.app.arn
}

output "role_name" {
  value = aws_iam_role.app.name
}

output "log_group_name" {
  value = module.log_group.name
}

