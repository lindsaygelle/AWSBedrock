data "aws_iam_policy_document" "assume_role_api_gateway_bedrock" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "assume_role_sfn_state_machine_bedrock_amazon_text" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      identifiers = ["states.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "api_gateway_rest_api_bedrock" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    effect = "Allow"
    resources = [
      "${aws_cloudwatch_log_group.api_gateway_rest_api_bedrock_latest.arn}"
    ]
  }
  statement {
    actions = [
      "states:StartSyncExecution"
    ]
    effect = "Allow"
    resources = [
      "${aws_sfn_state_machine.bedrock_amazon_text.arn}"
    ]
  }
}

data "aws_iam_policy_document" "s3_bucket_analytics" {
  statement {
    actions = ["s3:PutObject"]
    condition {
      test = "StringEquals"
      values = [
        "${aws_s3_bucket.cloudtrail.arn}",
        "${aws_s3_bucket.inventory.arn}",
        "${aws_s3_bucket.log.arn}",
        "${aws_s3_bucket.main.arn}",
      ]
      variable = "AWS:SourceArn"
    }
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
    effect = "Allow"
    principals {
      identifiers = ["s3.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.analytics.arn}/*"]
  }
}

data "aws_iam_policy_document" "s3_bucket_cloudtrail" {
  statement {
    actions = ["s3:GetBucketAcl"]
    condition {
      test     = "StringEquals"
      values   = ["arn:aws:cloudtrail:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:trail/${local.organization}"]
      variable = "AWS:SourceArn"
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
      variable = "AWS:SourceArn"
    }
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
    effect = "Allow"
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]
  }
}

data "aws_iam_policy_document" "s3_bucket_inventory" {
  statement {
    actions = ["s3:PutObject"]
    condition {
      test = "ArnLike"
      values = [
        "${aws_s3_bucket.analytics.arn}",
        "${aws_s3_bucket.cloudtrail.arn}",
        "${aws_s3_bucket.log.arn}",
        "${aws_s3_bucket.main.arn}"
      ]
      variable = "AWS:SourceArn"
    }
    condition {
      test     = "StringEquals"
      values   = ["${data.aws_caller_identity.main.account_id}"]
      variable = "aws:SourceAccount"
    }
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
    effect = "Allow"
    principals {
      identifiers = ["s3.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.inventory.arn}/*"]
  }
}

data "aws_iam_policy_document" "s3_bucket_log" {
  statement {
    actions = ["s3:PutObject"]
    condition {
      test = "ArnLike"
      values = [
        "${aws_s3_bucket.analytics.arn}",
        "${aws_s3_bucket.cloudtrail.arn}",
        "${aws_s3_bucket.inventory.arn}",
        "${aws_s3_bucket.main.arn}"
      ]
      variable = "AWS:SourceArn"
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

data "aws_iam_policy_document" "sfn_state_machine_bedrock_amazon_text" {
  statement {
    actions = ["bedrock:InvokeModel"]
    effect  = "Allow"
    resources = [
      "arn:aws:bedrock:${data.aws_region.main.name}::foundation-model/amazon.titan-text-express-v1",
      "arn:aws:bedrock:${data.aws_region.main.name}::foundation-model/amazon.titan-text-lite-v1",
      "arn:aws:bedrock:${data.aws_region.main.name}::foundation-model/amazon.titan-text-premier-v1:0",
    ]
  }
  statement {
    actions = [
      "logs:CreateLogDelivery",
      "logs:CreateLogStream",
      "logs:DeleteLogDelivery",
      "logs:DescribeLogGroups",
      "logs:DescribeResourcePolicies",
      "logs:GetLogDelivery",
      "logs:ListLogDeliveries",
      "logs:PutLogEvents",
      "logs:PutResourcePolicy",
      "logs:UpdateLogDelivery",
    ]
    effect = "Allow"
    resources = [
      "${aws_cloudwatch_log_group.sfn_state_machine_bedrock_amazon_text.arn}",
      "${aws_cloudwatch_log_group.sfn_state_machine_bedrock_amazon_text.arn}*",
    ]
  }
  statement {
    actions = [
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets",
      "xray:PutTelemetryRecords",
      "xray:PutTraceSegments",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
