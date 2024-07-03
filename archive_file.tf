data "archive_file" "lambda_function_bedrock_amazon_image_text_image" {
  output_path = "./lambda/function/bedrock/amazon/image/text_image/file.zip"
  source_dir  = "./lambda/function/bedrock/amazon/image/text_image/src"
  type        = "zip"
}
