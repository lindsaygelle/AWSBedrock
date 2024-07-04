data "archive_file" "lambda_function_bedrock_amazon_image_text_image" {
  output_path = "./lambda/function/bedrock/runtime/invoke_model/amazon/titan_image_generator/1.0/text_image/file.zip"
  source_dir  = "./lambda/function/bedrock/runtime/invoke_model/amazon/titan_image_generator/1.0/text_image/src"
  type        = "zip"
}
