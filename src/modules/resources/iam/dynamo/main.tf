data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:DescribeTimeToLive",
    ]

    resources = [
      "${var.dynamo_table_arn}",
      "${var.dynamo_table_arn}/index/*"
    ]
  }
}

resource "aws_iam_policy" "app" {
  name        = "${var.policy_name}"
  description = "Grant read and write access to specific DynamoDB table"
  policy      = "${data.aws_iam_policy_document.app.json}"
}
