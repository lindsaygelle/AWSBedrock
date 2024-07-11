/** API Gateway **/
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

/** Lambda Function **/
data "aws_iam_policy_document" "assume_role_lambda_function_write_amazon_titan_image_generator_v1_text_image" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

/** SFN State Machine **/
data "aws_iam_policy_document" "assume_role_sfn_state_machine_write_amazon_titan_image_generator_v1_text_image" {
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
      // "${aws_cloudwatch_log_group.api_gateway_rest_api_bedrock_latest.arn}"
      "*",
    ]
  }
  statement {
    actions = [
      "states:StartSyncExecution"
    ]
    effect = "Allow"
    resources = [
      "${aws_sfn_state_machine.write_amazon_titan_image_generator_v1_text_image.arn}",
    ]
  }
}

data "aws_iam_policy_document" "lambda_function_write_amazon_titan_image_generator_v1_text_image" {
  statement {
    actions = ["bedrock:InvokeModel"]
    effect  = "Allow"
    resources = [
      "arn:aws:bedrock:${data.aws_region.main.name}::foundation-model/amazon.titan-image-generator-v1",
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
      // "${aws_cloudwatch_log_group.lambda_function_bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image.arn}*",
      "*"
    ]
  }
  statement {
    actions = [
      "s3:HeadObject",
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.public.arn}*"
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


data "aws_iam_policy_document" "s3_bucket_analytics" {
  statement {
    actions = ["s3:PutObject"]
    condition {
      test = "StringEquals"
      values = [
        "${aws_s3_bucket.cloudtrail.arn}",
        "${aws_s3_bucket.inventory.arn}",
        "${aws_s3_bucket.log.arn}",
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

data "aws_iam_policy_document" "s3_bucket_public" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      "${aws_s3_bucket.public.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "sfn_state_machine_write_amazon_titan_image_generator_v1_text_image" {
  statement {
    actions = ["bedrock:InvokeModel"]
    effect  = "Allow"
    resources = [
      "arn:aws:bedrock:${data.aws_region.main.name}::foundation-model/amazon.titan-image-generator-v1",
    ]
  }
  statement {
    actions = ["lambda:InvokeFunction"]
    effect  = "Allow"
    resources = [
      "${aws_lambda_function.write_amazon_titan_image_generator_v1_text_image.arn}:${aws_lambda_alias.write_amazon_titan_image_generator_v1_text_image.function_version}"
    ]
  }
  statement {
    actions   = ["logs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sfn_state_machine_bedrock_invoke_model_amazon_titan_text" {
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
      // "${aws_cloudwatch_log_group.sfn_state_machine_bedrock_amazon_text.arn}*",
      "*",
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
