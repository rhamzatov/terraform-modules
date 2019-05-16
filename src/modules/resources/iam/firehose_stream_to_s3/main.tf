resource "aws_iam_role" "app" {
  name = "${var.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

module "array_transformation" {
  source = "../../../helpers/concat_string_to_array"
  input  = ["${var.buckets}"]
  suffix = "/*"
}

data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = ["${module.array_transformation.concatenated_array}"]
  }
}

resource "aws_iam_policy" "app" {
  name        = "${var.policy_name}"
  description = "Allows Kinesis Firehose to access S3 bucket"
  policy      = "${data.aws_iam_policy_document.app.json}"
}

resource "aws_iam_role_policy_attachment" "app" {
  role       = "${aws_iam_role.app.name}"
  policy_arn = "${aws_iam_policy.app.arn}"
}
