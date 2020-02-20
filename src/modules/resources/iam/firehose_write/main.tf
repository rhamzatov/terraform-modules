data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [var.stream_arn]
  }
}

resource "aws_iam_policy" "app" {
  name        = var.policy_name
  description = "Allows write to Kinesis Firehose"
  policy      = data.aws_iam_policy_document.app.json
}

