output "name" {
  value = "${aws_cloudwatch_log_metric_filter.app.id}"
}
