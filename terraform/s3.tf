

# See https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
data "aws_iam_policy_document" "origin_bucket_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.abdul_hosting.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.distribution.arn]
    }
  }
}

# Link the policy you create(Origin Policy) wiht buket. To make connectoin between these two
resource "aws_s3_bucket_policy" "abdul_hosting" {
  bucket = aws_s3_bucket.abdul_hosting.bucket
  policy = data.aws_iam_policy_document.origin_bucket_policy.json
}


resource "aws_s3_bucket" "abdul_hosting" {
  bucket = "sell-my-stuff-frontend-abdul"

  tags = {
    Project = local.project
  }
}