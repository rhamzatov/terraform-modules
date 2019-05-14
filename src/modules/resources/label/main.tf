locals {
  id = "${join(var.delimiter, compact(concat(list(var.application, var.name, var.environment), var.attributes)))}"

  # https://wiki.albelli.net/wiki/Albelli_AWS_Tagging_standards
  tags = "${
      merge( 
        map(
          "Service", "${var.service}",
          "Environment", "${var.environment}",
          "Cost Center", "${var.cost_center}",
          "Application", "${var.application}",
          "Team", "${var.team}",
          "Name", "${var.name}"
        ), var.tags
      )
    }"
}
