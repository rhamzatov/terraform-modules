output "id" {
  value       = "${local.id}"
  description = "Disambiguated ID"
}

output "tags" {
  value       = "${local.tags}"
  description = "Normalized Tag map"
}
