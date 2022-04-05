resource "aws_iam_user" "user" {
  name = var.name
  tags = var.additional_tags
}

data "aws_iam_policy_document" "s3_write" {
  statement {
    sid = "S3BucketActions"
    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning"
    ]
    resources = [
      var.bucket_arn
    ]
  }

  statement {
    sid     = "S3ObjectWrite"
    actions = ["s3:*"]
    resources = [
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
