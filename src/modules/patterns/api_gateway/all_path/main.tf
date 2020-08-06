terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 3.0"
}

provider "aws" {
  alias  = "us-east-1"
  version = "~> 3.0"
}

module "certificate" {
  source      = "../../acm_certificate/with_validation"
  zone_id     = var.zone_id
  domain_name = var.domain
  tags        = var.tags

  providers = {
    aws = aws.us-east-1
  }
}

resource "aws_api_gateway_rest_api" "app" {
  name = var.name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_domain_name" "app" {
  domain_name = var.domain

  certificate_arn = module.certificate.arn
}

resource "aws_route53_record" "custom_domain_dns_record" {
  zone_id = var.zone_id
  name    = aws_api_gateway_domain_name.app.domain_name
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.app.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.app.cloudfront_zone_id
    evaluate_target_health = true
  }
}

resource "aws_api_gateway_resource" "app_public" {
  rest_api_id = aws_api_gateway_rest_api.app.id
  parent_id   = aws_api_gateway_rest_api.app.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "app_public" {
  rest_api_id   = aws_api_gateway_rest_api.app.id
  resource_id   = aws_api_gateway_resource.app_public.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "app_public" {
  rest_api_id = aws_api_gateway_rest_api.app.id
  resource_id = aws_api_gateway_method.app_public.resource_id
  http_method = aws_api_gateway_method.app_public.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_method" "app_public_root" {
  rest_api_id   = aws_api_gateway_rest_api.app.id
  resource_id   = aws_api_gateway_rest_api.app.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "app_public_root" {
  rest_api_id = aws_api_gateway_rest_api.app.id
  resource_id = aws_api_gateway_method.app_public_root.resource_id
  http_method = aws_api_gateway_method.app_public_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "app" {
  depends_on = [
    aws_api_gateway_integration.app_public,
    aws_api_gateway_integration.app_public_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.app.id
  stage_name  = var.stage_name
}

resource "aws_api_gateway_base_path_mapping" "app" {
  api_id      = aws_api_gateway_rest_api.app.id
  stage_name  = aws_api_gateway_deployment.app.stage_name
  domain_name = aws_api_gateway_domain_name.app.domain_name
}
