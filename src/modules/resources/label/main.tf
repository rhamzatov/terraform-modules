locals {
  id = join(
    var.delimiter,
    compact(
      concat([var.application, var.name, var.environment], var.attributes),
    ),
  )

  id_without_env = join(
    var.delimiter,
    compact(concat([var.application, var.name], var.attributes)),
  )

  # https://wiki.albelli.net/wiki/Albelli_AWS_Tagging_standards
  tags = merge(
    {
      "Domain"      = lower(var.domain)
      "Environment" = lower(var.environment)
      "Cost Center" = lower(var.cost_center)
      "Application" = lower(var.application)
      "Team"        = lower(var.team)
    },
    var.tags,
  )
}

