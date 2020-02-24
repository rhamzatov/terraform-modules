module "destination_bucket" {
  source = "../../resources/s3/private_bucket"
  name   = var.destination_bucket_name
  tags   = var.tags
}

module "kinesis_role" {
  source      = "../../resources/iam/firehose_stream_to_s3"
  role_name   = "${var.name}-Kinesis"
  policy_name = "${var.name}-Kinesis-Write-To-S3"
  buckets     = [module.destination_bucket.arn]
}

module "stream" {
  source                     = "../../resources/firehose/s3_destination"
  name                       = var.name
  role_arn                   = module.kinesis_role.arn
  bucket_arn                 = module.destination_bucket.arn
  buffer_interval_in_seconds = var.buffer_interval_in_seconds
  buffer_size_in_mb          = var.buffer_size_in_mb
  tags                       = var.tags
}

module "write_policy" {
  source      = "../../resources/iam/firehose_write"
  stream_arn  = module.stream.arn
  policy_name = "${var.name}-Write-To-Kinesis"
}

# SumoLogic resources
resource "aws_iam_role" "sumologic" {
  name = "${var.name}-Sumo-Read-From-S3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.sumo_aws_account}:root"
      },
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.sumo_external_id}"
        }
      }
    }
  ]
}
EOF

}

resource "aws_iam_policy" "sumologic" {
  name = "${var.name}-Sumo-Read-From-S3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:ListBucketVersions",
                "s3:ListBucket"
            ],
            "Effect": "Allow",
      "Resource": [ 
          "${module.destination_bucket.arn}", 
          "${module.destination_bucket.arn}/*"]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "sumologic" {
  role       = aws_iam_role.sumologic.name
  policy_arn = aws_iam_policy.sumologic.arn
}

# Notification

resource "aws_sns_topic" "notification" {
  name = "S3-${var.destination_bucket_name}-created-events"
}

resource "aws_s3_bucket_notification" "notification" {
  bucket = module.destination_bucket.name

  topic {
    topic_arn = aws_sns_topic.notification.arn
    events    = ["s3:ObjectCreated:*"]
  }
}

resource "aws_sns_topic_policy" "notification" {
  arn = aws_sns_topic.notification.arn

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:Publish"
      ],
      "Resource": "${aws_sns_topic.notification.arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "${module.destination_bucket.arn}"
        }
      }
    }
  ]
}
EOF

}

resource "aws_sns_topic_subscription" "notification" {
  count                  = var.sumo_notification_endpoint != "" ? 1 : 0
  topic_arn              = aws_sns_topic.notification.arn
  protocol               = "https"
  endpoint               = var.sumo_notification_endpoint
  endpoint_auto_confirms = true
}

