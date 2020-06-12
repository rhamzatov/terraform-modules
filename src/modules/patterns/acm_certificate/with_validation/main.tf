provider "aws" {}

resource "aws_acm_certificate" "app" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  tags              = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "app" {
  name            = aws_acm_certificate.app.domain_validation_options[0].resource_record_name
  type            = aws_acm_certificate.app.domain_validation_options[0].resource_record_type
  zone_id         = var.zone_id
  records         = [aws_acm_certificate.app.domain_validation_options[0].resource_record_value]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "app" {
  certificate_arn = aws_acm_certificate.app.arn

  validation_record_fqdns = [
    aws_route53_record.app.fqdn,
  ]
}
