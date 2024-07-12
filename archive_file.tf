data "archive_file" "lambda_function_write_amazon_titan_image_generator_v1_text_image" {
  output_path = "./lambda/function/write_amazon_titan_image_generator_v1_text_image/file.zip"
  source_dir  = "./lambda/function/write_amazon_titan_image_generator_v1_text_image/src"
  type        = "zip"
}

data "archive_file" "lambda_function_write_stability_ai_diffusion_v1_text_to_image" {
  output_path = "./lambda/function/write_stability_ai_diffusion_v1_text_to_image/file.zip"
  source_dir  = "./lambda/function/write_stability_ai_diffusion_v1_text_to_image/src"
  type        = "zip"
}

data "archive_file" "lambda_layer_bedrock" {
  output_path = "./lambda/layer/bedrock/file.zip"
  source_dir  = "./lambda/layer/bedrock/src"
  type        = "zip"
}

data "archive_file" "lambda_layer_s3" {
  output_path = "./lambda/layer/s3/file.zip"
  source_dir  = "./lambda/layer/s3/src"
  type        = "zip"
}

data "archive_file" "lambda_layer_titan" {
  output_path = "./lambda/layer/titan/file.zip"
  source_dir  = "./lambda/layer/titan/src"
  type        = "zip"
}
