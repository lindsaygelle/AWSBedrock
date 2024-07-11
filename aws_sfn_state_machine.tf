resource "aws_sfn_state_machine" "bedrock_invoke_model_amazon_titan_image_generator_text_image" {
  definition = templatefile("./step_function/state_machine/api_gateway/rest_api/bedrock/AmazonTitanImageGeneratorV1TextImage.json", {
    aws_lambda_function_arn           = aws_lambda_function.bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image.arn
    aws_lambda_alias_function_version = aws_lambda_alias.bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image.function_version
    aws_region                        = data.aws_region.main.name
  })
  name     = "bedrock-invoke-model-amazon-titan-image-generator-v1-text-image"
  publish  = false
  role_arn = aws_iam_role.sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator.arn
  tags     = local.tags
  tracing_configuration {
    enabled = true
  }
  type = "EXPRESS"
}

resource "aws_sfn_state_machine" "bedrock_invoke_model_amazon_titan_text" {
  definition = templatefile("./step_function/state_machine/bedrock/runtime/invoke_model/amazon/titan/Text.json", {
    aws_region = data.aws_region.main.name
  })
  name     = "bedrock-invoke-model-amazon-titan-text"
  publish  = false
  role_arn = aws_iam_role.sfn_state_machine_bedrock_invoke_model_amazon_titan_text.arn
  tags     = local.tags
  tracing_configuration {
    enabled = true
  }
  type = "EXPRESS"
}
