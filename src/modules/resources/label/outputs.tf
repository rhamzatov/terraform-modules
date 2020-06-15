output "id" {
  value       = local.id
  description = "Fixed ID for static names (e.g. lambda name)"
}

// NOTE: still here for backward compatibility, can be removed next major release
output "id_without_env" {
  value       = local.id
  description = "Fixed ID for static names (e.g. lambda name)"
}

output "id_env" {
  value       = local.id_with_env
  description = "Disambiguated ID"
}

output "tags" {
  value       = local.tags
  description = "Normalized Tag map"
}
