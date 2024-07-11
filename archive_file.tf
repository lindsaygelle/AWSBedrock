data "archive_file" "lambda_function_write_amazon_titan_image_generator_v1_text_image" {
  output_path = "./lambda/function/WriteAmazonTitanImageGeneratorV1TextImage/file.zip"
  source_dir  = "./lambda/function/WriteAmazonTitanImageGeneratorV1TextImage/src"
  type        = "zip"
}
