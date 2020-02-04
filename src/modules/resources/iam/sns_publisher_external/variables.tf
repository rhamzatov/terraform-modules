variable "sns_arn" {}

variable "owner_account_id" {}

variable "owner_sid" {
  default = "Owner rights"
}

variable "publisher_account_id" {}

variable "publisher_sid" {
  default = "External publisher rights"
}
