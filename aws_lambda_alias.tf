resource "aws_lambda_alias" "bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image" {
  description      = null
  function_name    = aws_lambda_function.bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image.arn
  function_version = "$LATEST"
  name             = "LATEST"
}
