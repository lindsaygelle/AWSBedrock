resource "aws_lambda_alias" "write_amazon_titan_image_generator_v1_text_image" {
  description      = null
  function_name    = aws_lambda_function.write_amazon_titan_image_generator_v1_text_image.arn
  function_version = "$LATEST"
  name             = "LATEST"
}
