variable "name" {
  description = "API name"
}

variable "stage_name" {
  default = "Default"
}

variable "domain" {
}

variable "zone_id" {
}

variable "lambda_invoke_arn" {
}

variable "tags" {
  type = map(string)
}

