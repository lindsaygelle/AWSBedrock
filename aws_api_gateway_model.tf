resource "aws_api_gateway_model" "bedrock_write_amazon_titan_image_generator_v1_image_generation_config" {
  content_type = "application/json"
  name         = "WriteAmazonTitanImageGeneratorV1ImageGenerationConfig"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/WriteAmazonTitanImageGeneratorV1ImageGenerationConfig.json", {})
}

resource "aws_api_gateway_model" "bedrock_write_amazon_titan_image_generator_v1_text_to_image_params" {
  content_type = "application/json"
  name         = "WriteAmazonTitanImageGeneratorV1TextToImageParams"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/WriteAmazonTitanImageGeneratorV1TextToImageParams.json", {})
}

resource "aws_api_gateway_model" "bedrock_write_amazon_titan_image_generator_v1_text_image" {
  content_type = "application/json"
  name         = "WriteAmazonTitanImageGeneratorV1TextImage"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema = templatefile("./api_gateway/rest_api/bedrock/model/request/WriteAmazonTitanImageGeneratorV1TextImage.json", {
    image_generation_config = aws_api_gateway_model.bedrock_write_amazon_titan_image_generator_v1_image_generation_config.name
    rest_api_id             = aws_api_gateway_rest_api.bedrock.id
    text_to_image_params    = aws_api_gateway_model.bedrock_write_amazon_titan_image_generator_v1_text_to_image_params.name
  })
}

resource "aws_api_gateway_model" "bedrock_write_amazon_titan_image_generator_v1_text_image_200" {
  content_type = "application/json"
  name         = "WriteAmazonTitanImageGeneratorV1TextImage200"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/response/WriteAmazonTitanImageGeneratorV1TextImage200.json", {})
}

resource "aws_api_gateway_model" "bedrock_write_amazon_titan_text_express" {
  content_type = "application/json"
  name         = "WriteAmazonTitanTextExpress"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/WriteAmazonTitanTextExpress.json", {})
}

resource "aws_api_gateway_model" "bedrock_write_amazon_titan_text_lite" {
  content_type = "application/json"
  name         = "WriteAmazonTitanTextLite"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/WriteAmazonTitanTextLite.json", {})
}

resource "aws_api_gateway_model" "bedrock_write_amazon_titan_text_premier" {
  content_type = "application/json"
  name         = "WriteAmazonTitanTextPremier"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/WriteAmazonTitanTextPremier.json", {})
}
