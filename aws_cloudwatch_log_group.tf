resource "aws_cloudwatch_log_group" "api_gateway_rest_api_bedrock_latest" {
  log_group_class   = "STANDARD"
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_stage.bedrock.rest_api_id}/${aws_api_gateway_stage.bedrock.stage_name}"
  retention_in_days = 7
  skip_destroy      = false
  tags              = local.tags
}

resource "aws_cloudwatch_log_group" "lambda_function_bedrock_amazon_image_text_image" {
  log_group_class   = "STANDARD"
  name              = "/aws/lambda/${local.organization}-bedrock-amazon-image-text-image"
  retention_in_days = 7
  skip_destroy      = false
  tags              = local.tags
}

resource "aws_cloudwatch_log_group" "sfn_state_machine_bedrock_amazon_text" {
  log_group_class   = "STANDARD"
  name              = "/aws/vendedlogs/states/${local.organization}-bedrock-amazon-text"
  retention_in_days = 7
  skip_destroy      = false
  tags              = local.tags
}
