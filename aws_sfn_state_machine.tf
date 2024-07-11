resource "aws_sfn_state_machine" "write_amazon_titan_image_generator_v1_text_image" {
  definition = templatefile("./step_function/state_machine/WriteAmazonTitanImageGeneratorV1TextImage.json", {
    aws_lambda_function_arn           = aws_lambda_function.write_amazon_titan_image_generator_v1_text_image.arn
    aws_lambda_alias_function_version = aws_lambda_alias.write_amazon_titan_image_generator_v1_text_image.function_version
    aws_region                        = data.aws_region.main.name
  })
  name     = "WriteAmazonTitanImageGeneratorV1TextImage"
  publish  = false
  role_arn = aws_iam_role.sfn_state_machine_write_amazon_titan_image_generator_v1_text_image.arn
  tags     = local.tags
  tracing_configuration {
    enabled = true
  }
  type = "EXPRESS"
}
