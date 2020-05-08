terraform {
  required_version = ">= 0.12"
}

resource "aws_security_group" "app" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = var.ingress_ip_ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_ip_ranges
  }

  tags = var.tags
}
