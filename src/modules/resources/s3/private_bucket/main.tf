resource "aws_s3_bucket" "app" {
  acl    = "private"
  bucket = var.name
  tags   = var.tags
}

