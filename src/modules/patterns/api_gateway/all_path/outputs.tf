output "base_generated_url" {
  value = "${aws_api_gateway_deployment.app.invoke_url}"
}

output "base_url" {
  value = "https://${aws_api_gateway_domain_name.app.domain_name}"
}

output "execution_arn" {
  value = "${aws_api_gateway_rest_api.app.execution_arn}"
}