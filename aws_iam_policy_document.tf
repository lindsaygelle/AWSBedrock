data "aws_iam_policy_document" "assume_role_api_gateway" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "api_gateway_rest_api" {
  statement {
    actions = [
      "logs:CreateLogDelivery",
      "logs:CreateLogGroup",
      "logs:DeleteLogDelivery",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:DescribeResourcePolicies",
      "logs:FilterLogEvents",
      "logs:GetLogDelivery",
      "logs:GetLogEvents",
      "logs:ListLogDeliveries",
      "logs:PutResourcePolicy",
      "logs:UpdateLogDelivery"
    ]
    resources = [
      "${aws_cloudwatch_log_group.api_gateway_rest_api.arn}/*"
    ]
  }
}

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
