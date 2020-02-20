data "aws_iam_policy_document" "app" {
  statement {
    actions = [
      "es:ESHttpHead",
      "es:ESHttpGet",
      "es:ESHttpPost",
      "es:ESHttpPut",
      "es:ESHttpDelete",
      "es:DescribeElasticsearchDomain",
      "es:DescribeElasticsearchDomainConfig",
      "es:GetUpgradeStatus",
      "es:GetUpgradeHistory",
    ]

    resources = ["${var.elasticsearch_domain_arn}/*"]
  }
}

resource "aws_iam_policy" "app" {
  name        = var.policy_name
  description = "Grant read and write access to specific Elasticsearch domain"
  policy      = data.aws_iam_policy_document.app.json
}

