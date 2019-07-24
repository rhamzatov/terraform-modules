resource "aws_cloudwatch_metric_alarm" "app" {
  alarm_name          = "${var.alarm_name}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  datapoints_to_alarm = "${var.datapoints_to_alarm}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold}"
  alarm_description   = "${var.alarm_description}"
  alarm_actions       = ["${var.alarm_actions}"]
  tags                = "${var.tags}"
}
