/*
resource "aws_cloudwatch_log_group" "api_gateway_rest_api_bedrock_latest" {
  log_group_class   = "STANDARD"
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_stage.bedrock.rest_api_id}/${aws_api_gateway_stage.bedrock.stage_name}"
  retention_in_days = 7
  skip_destroy      = false
  tags              = local.tags
}

resource "aws_cloudwatch_log_group" "lambda_function_bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image" {
  log_group_class   = "STANDARD"
  name              = "/aws/lambda/bedrock-runtime-invoke-model-amazon-titan-image-generator-v1-text-image"
  retention_in_days = 7
  skip_destroy      = false
  tags              = local.tags
}

resource "aws_cloudwatch_log_group" "sfn_state_machine_bedrock_amazon_text" {
  log_group_class   = "STANDARD"
  name              = "/aws/vendedlogs/states/bedrock-amazon-text"
  retention_in_days = 7
  skip_destroy      = false
  tags              = local.tags
}
*/
