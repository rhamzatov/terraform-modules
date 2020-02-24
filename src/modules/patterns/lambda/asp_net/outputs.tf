output "lambda_arn" {
  value = module.lambda.lambda_arn
}

output "role_arn" {
  value = module.lambda.role_arn
}

output "role_name" {
  value = module.lambda.role_name
}

output "base_generated_url" {
  value = module.api.base_generated_url
}

output "base_url" {
  value = module.api.base_url
}

