resource "aws_iam_user" "user" {
  name = var.name
  tags = var.additional_tags
}

data "aws_iam_policy_document" "s3_write" {
  statement {
    sid = "S3List"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:HeadBucket"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "S3Write"
    actions = ["s3:*"]
    resources = [
      var.bucket_arn,
      "${var.bucket_arn}${var.bucket_prefix}"
    ]
  }
}

resource "aws_iam_user_policy" "s3_write" {
  name   = var.name
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.s3_write.json
}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}
