terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 3.0"
}

resource "aws_acm_certificate" "app" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  tags              = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "app" {
  depends_on = [ aws_acm_certificate.app ]
  for_each = {
    for dvo in aws_acm_certificate.app.domain_validation_options: dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = var.zone_id
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "app" {
  depends_on = [ aws_route53_record.app ]

  certificate_arn = aws_acm_certificate.app.arn

  validation_record_fqdns = [for record in aws_route53_record.app: record.fqdn]
}
