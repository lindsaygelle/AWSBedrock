data "archive_file" "lambda_function_bedrock_runtime_invoke_model_amazon_titan_image_generator_v1_text_image" {
  output_path = "./lambda/function/bedrock/runtime/invoke_model/amazon.titan-image-generator-v1/text_image/file.zip"
  source_dir  = "./lambda/function/bedrock/runtime/invoke_model/amazon.titan-image-generator-v1/text_image/src"
  type        = "zip"
}
