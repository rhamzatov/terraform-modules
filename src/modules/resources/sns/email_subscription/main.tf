resource "null_resource" "sns_subscribe" {
  count = "${length(var.emails)}"

  triggers = {
    sns_topic_arn = "${var.sns_topic_arn}"
  }

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${var.sns_topic_arn} --protocol email --notification-endpoint ${element(var.emails, count.index)} --region ${var.region}"
  }
}
