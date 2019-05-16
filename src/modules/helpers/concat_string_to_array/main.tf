variable "input" {
  type        = "list"
  description = "Input array of strings"
}

variable "suffix" {
  default     = "/*"
  description = "value to concat"
}

locals {
  joied_values = "${formatlist("%s%s", var.input, var.suffix)}"
}

locals {
  concatenated_array = "${concat(var.input, local.joied_values)}"
}

output "new_array" {
  value = "${local.joied_values}"
}

output "concatenated_array" {
  value = "${local.concatenated_array}"
}
