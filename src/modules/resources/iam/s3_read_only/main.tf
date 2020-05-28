terraform {
  required_version = ">= 0.12"
}

data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "s3:HeadBucket",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:ListBucketVersions",
    ]

    resources = ["${var.s3_bucket_arn}", "${var.s3_bucket_arn}/*"]
  }
}

resource "aws_iam_policy" "app" {
  name        = var.policy_name
  description = "Grant read access to specific S3 bucket"
  policy      = data.aws_iam_policy_document.app.json
}
