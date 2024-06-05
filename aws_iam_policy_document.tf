data "aws_iam_policy_document" "s3_bucket_cloudtrail" {
  statement {
    actions = ["s3:GetBucketAcl"]
    condition {
      test     = "StringEquals"
      values   = ["arn:aws:cloudtrail:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:trail/${local.organization}"]
      variable = "aws:SourceArn"
    }
    effect = "Allow"
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.cloudtrail.arn}"]
  }
  statement {
    actions = ["s3:PutObject"]
    condition {
      test     = "StringEquals"
      values   = ["arn:aws:cloudtrail:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:trail/${local.organization}"]
      variable = "aws:SourceArn"
    }
    effect = "Allow"
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]
  }
}

data "aws_iam_policy_document" "s3_bucket_log" {
  statement {
    actions = ["s3:PutObject"]
    condition {
      test = "ArnLike"
      values = [
        "${aws_s3_bucket.cloudtrail.arn}",
        "${aws_s3_bucket.inventory.arn}",
        "${aws_s3_bucket.main.arn}"
      ]
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
    resources = ["${aws_s3_bucket.log.arn}/*"]
  }
}
