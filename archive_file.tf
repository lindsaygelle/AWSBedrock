data "archive_file" "lambda_function_bedrock_amazon_image" {
  output_path = "./lambda/function/bedrock/amazon/image/file.zip"
  source_dir  = "./lambda/function/bedrock/amazon/image/src"
  type        = "zip"
}
