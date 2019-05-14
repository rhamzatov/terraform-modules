variable "application" {
  default     = ""
  description = "Namespace, which could be your project name, e.g. `backoffice` or `fulfillment`"
}

variable "name" {
  description = "Component name, e.g. `app`"
}

variable "environment" {
  description = "Stage, e.g. `test`, `acc` or `prod`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes, e.g. `1`"
}

variable "service" {
  description = "The group name of one or multiple applications"
}

variable "cost_center" {
  description = "The cost center of the resource, dictionary: https://wiki.albelli.net/wiki/Albelli_Cost_Centers"
}

variable "team" {
  default     = ""
  description = "The name of the team that is owner of the resource, dictionary: https://wiki.albelli.net/wiki/Albelli_IT_Squads"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `application`, `name` and `environment`"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags"
}
