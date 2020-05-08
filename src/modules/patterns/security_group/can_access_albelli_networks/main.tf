terraform {
  required_version = ">= 0.12"
}

module "ranges" {
  source = "../../../resources/ip_ranges/albelli"
}

locals {
  merged_ip_ranges = concat(module.ranges.value, var.extra_ranges)
}

module "security_group" {
  source            = "../../../resources/security_group/plain"
  name              = var.name
  vpc_id            = var.vpc_id
  ingress_ip_ranges = local.merged_ip_ranges
  tags              = var.tags
}
