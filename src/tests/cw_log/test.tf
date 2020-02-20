provider "aws" {
  region = "eu-west-1"
}

locals {
  log_name = "test-cw-log"
}

module "label" {
  source      = "../../modules/resources/label"
  application = "test-app"
  name        = "app"
  environment = "test"
  domain      = "ci-cd platform"
  cost_center = "3600"
  team        = "customer care technology"
}

module "log_group" {
  source = "../../modules/resources/cw/log_group"
  name   = local.log_name
  tags   = module.label.tags
}

module "filter" {
  source         = "../../modules/resources/cw/metric_filter"
  name           = "${local.log_name}-filter"
  log_group_name = module.log_group.name
  pattern        = "test pattern"
}

module "alarm" {
  source              = "../../modules/resources/cw/statistic_metric_alarm"
  alarm_name          = "${local.log_name}-alarm"
  metric_name         = "${local.log_name}-metric"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  threshold           = "1"
  alarm_actions       = []
}

