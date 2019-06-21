resource "aws_cloudwatch_log_metric_filter" "app" {
  name           = "${var.name}"
  pattern        = "${var.pattern}"
  log_group_name = "${var.log_group_name}"

  metric_transformation {
    name          = "${var.name}"
    namespace     = "${var.transformation_namespace}"
    value         = "${var.transformation_value}"
    default_value = "${var.transformation_default_value}"
  }
}
