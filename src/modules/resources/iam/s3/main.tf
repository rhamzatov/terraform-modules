data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = ["${var.s3_bucket_arn}"]
  }
}

resource "aws_iam_policy" "app" {
  name        = "${var.policy_name}"
  description = "Grant read and write access to specific S3 bucket"
  policy      = "${data.aws_iam_policy_document.app.json}"
}
