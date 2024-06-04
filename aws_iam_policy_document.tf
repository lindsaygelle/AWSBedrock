data "aws_iam_policy_document" "s3_bucket_logging" {
  statement {
    actions = ["s3:PutObject"]
    condition {
      test     = "ArnLike"
      values   = ["${aws_s3_bucket.main.arn}"]
      variable = "aws:SourceArn"
    }
    condition {
      test     = "StringEquals"
      values   = ["${data.aws_caller_identity.main.account_id}"]
      variable = "aws:SourceAccount"
    }
    effect = "Allow"
    principals {
      identifiers = ["logging.s3.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.main.arn}/${aws_s3_object.log.key}*"]
  }
}
