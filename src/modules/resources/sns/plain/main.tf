resource "aws_sns_topic" "app" {
  name = var.name
  #tags = "${var.tags}"
}

