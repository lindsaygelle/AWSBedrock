resource "aws_lambda_alias" "bedrock_amazon_image_text_image" {
  description      = null
  function_name    = aws_lambda_function.bedrock_amazon_image_text_image.arn
  function_version = "$LATEST"
  name             = "LATEST"
}
