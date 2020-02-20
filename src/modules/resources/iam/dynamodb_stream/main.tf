resource "aws_iam_policy" "app" {
  name        = var.policy_name
  description = "Grant access for streaming events from DynamoDB table to a lambda."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:ListStreams"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeStream",
                "dynamodb:GetRecords",
                "dynamodb:GetShardIterator"
            ],
            "Resource": "${var.stream_arn}"
        }
    ]
}
EOF

}

