module "lambda" {
  source         = "../with_cw_logs"
  name           = "${var.app_name}"
  description    = "${var.description}"
  s3_bucket_name = "${var.s3_bucket_name}"
  s3_bucket_path = "${var.s3_bucket_path}"
  handler        = "${var.handler}"
  runtime        = "${var.runtime}"
  memory_size    = "${var.memory_size}"
  timeout        = "${var.timeout}"
  variables      = "${var.variables}"

  log_retention_days = "${var.log_retention_days}"

  max_concurrent_executions = -1

  tags = "${var.tags}"
}

module "error_topic" {
  source = "../../../resources/sns/plain"
  name   = "${var.app_name}-LogErrors"
  tags   = "${var.tags}"
}

module "email_subscriptions" {
  source        = "../../../resources/sns/email_subscription"
  sns_topic_arn = "${module.error_topic.arn}"
  emails        = "${var.emails}"
}

module "metric_filter" {
  source         = "../../../resources/cw/metric_filter"
  name           = "${var.app_name}-ErrorFilter"
  pattern        = "${var.pattern}"
  log_group_name = "${module.lambda.log_group_name}"
}

module "metric_alarm" {
  source              = "../../../resources/cw/statistic_metric_alarm"
  alarm_name          = "${var.app_name}-ErrorAlarm"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${module.metric_filter.name}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold}"
  alarm_description   = "This metric alerts on ${var.app_name} errors"
  alarm_actions       = ["${module.error_topic.arn}"]
}
