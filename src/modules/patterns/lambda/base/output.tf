output "arn" {
  value = "${element(concat(module.fromS3.arn, module.fromFile.arn, list("")), 0)}"
}

output "qualified_arn" {
  value = "${element(concat(module.fromS3.qualified_arn, module.fromFile.qualified_arn, list("")), 0)}"
}

output "invoke_arn" {
  value = "${element(concat(module.fromS3.invoke_arn, module.fromFile.invoke_arn, list("")), 0)}"
}
