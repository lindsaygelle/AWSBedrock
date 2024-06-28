data "archive_file" "lambda_function_bedrock_amazon_titan_image" {
  output_path = "./lambda/function/bedrock/amazon/titan/image/file.zip"
  source_dir  = "./lambda/function/bedrock/amazon/titan/image/src"
  type        = "zip"
}
