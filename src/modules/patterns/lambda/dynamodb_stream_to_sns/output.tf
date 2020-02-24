output "lambda_arn" {
  value = module.app.lambda_arn
}

output "lambda_invoke_arn" {
  value = module.app.lambda_invoke_arn
}

output "role_arn" {
  value = module.app.role_arn
}

output "role_name" {
  value = module.app.role_name
}

output "log_group_name" {
  value = module.app.log_group_name
}

