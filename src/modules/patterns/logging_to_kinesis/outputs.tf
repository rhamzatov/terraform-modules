output "kinesis_arn" {
  value       = "${module.stream.arn}"
  description = "Firehose stream ARN."
}

output "write_policy_arn" {
  value       = "${module.write_policy.arn}"
  description = "The ARN of the write to Firehose stream policy."
}

output "sumologic_role_arn" {
  value = "${aws_iam_role.sumologic.arn}"
}

output "sumologic_basic_path_expression" {
  value = "To match all files in all directories, use the path expression '*/*/*/*/*' (YYYY/MM/DD/HH/file_name)"
}
