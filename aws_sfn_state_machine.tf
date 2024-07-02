resource "aws_sfn_state_machine" "bedrock_amazon_image_text_image" {
  definition = templatefile("./step_function/state_machine/BedrockInvokeModelAmazonImageTextImage.json", {
    aws_lambda_function_arn           = aws_lambda_function.bedrock_amazon_image.arn
    aws_lambda_alias_function_version = aws_lambda_alias.bedrock_amazon_image.function_version
    aws_region                        = data.aws_region.main.name
  })
  /*
  logging_configuration {
    include_execution_data = true
    level                  = "ALL"
    log_destination        = "${aws_cloudwatch_log_group.sfn_state_machine_bedrock_amazon_text.arn}:*"
  }
  */
  name     = "${local.organization}-bedrock-amazon-image-text-image"
  publish  = false
  role_arn = aws_iam_role.sfn_state_machine_bedrock_amazon_image_text_image.arn
  tags     = local.tags
  tracing_configuration {
    enabled = true
  }
  type = "EXPRESS"
}

resource "aws_sfn_state_machine" "bedrock_amazon_text" {
  definition = templatefile("./step_function/state_machine/BedrockInvokeModelAmazonText.json", {
    aws_region = data.aws_region.main.name
  })
  /*
  logging_configuration {
    include_execution_data = true
    level                  = "ALL"
    log_destination        = "${aws_cloudwatch_log_group.sfn_state_machine_bedrock_amazon_text.arn}:*"
  }
  */
  name     = "${local.organization}-bedrock-amazon-text"
  publish  = false
  role_arn = aws_iam_role.sfn_state_machine_bedrock_amazon_text.arn
  tags     = local.tags
  tracing_configuration {
    enabled = true
  }
  type = "EXPRESS"
}
