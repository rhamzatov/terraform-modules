output "id" {
  value       = "${local.id}"
  description = "Disambiguated ID"
}

output "id_without_env" {
  value       = "${local.id_without_env}"
  description = "Fixed ID for static names (e.g. lambda name)"
}

output "tags" {
  value       = "${local.tags}"
  description = "Normalized Tag map"
}
