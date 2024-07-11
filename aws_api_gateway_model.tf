resource "aws_api_gateway_model" "bedrock_amazon_titan_image_generator_v1_image_generation_config" {
  content_type = "application/json"
  name         = "AmazonTitanImageGeneratorV1ImageGenerationConfig"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/AmazonTitanImageGeneratorV1ImageGenerationConfig.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_titan_image_generator_v1_text_to_image_params" {
  content_type = "application/json"
  name         = "AmazonTitanImageGeneratorV1TextToImageParams"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/AmazonTitanImageGeneratorV1TextToImageParams.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_titan_image_generator_v1_text_image" {
  content_type = "application/json"
  name         = "AmazonTitanImageGeneratorV1TextImage"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema = templatefile("./api_gateway/rest_api/bedrock/model/request/AmazonTitanImageGeneratorV1TextImage.json", {
    image_generation_config = aws_api_gateway_model.bedrock_amazon_titan_image_generator_v1_image_generation_config.name
    rest_api_id             = aws_api_gateway_rest_api.bedrock.id
    text_to_image_params    = aws_api_gateway_model.bedrock_amazon_titan_image_generator_v1_text_to_image_params.name
  })
}

resource "aws_api_gateway_model" "bedrock_amazon_titan_text_express" {
  content_type = "application/json"
  name         = "AmazonTitanTextExpress"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/AmazonTitanTextExpress.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_titan_text_lite" {
  content_type = "application/json"
  name         = "AmazonTitanTextLite"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/AmazonTitanTextLite.json", {})
}
resource "aws_api_gateway_model" "bedrock_amazon_titan_text_premier" {
  content_type = "application/json"
  name         = "AmazonTitanTextPremier"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/request/AmazonTitanTextPremier.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_image_variation_write_request" {
  content_type = "application/json"
  name         = "AmazonImageImageVariationWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageImageVariationWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_inpainting_write_request" {
  content_type = "application/json"
  name         = "AmazonImageInpaintingWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageInpaintingWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_outpainting_write_request" {
  content_type = "application/json"
  name         = "AmazonImageOutpaintingWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageOutpaintingWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_text_image_write_request" {
  content_type = "application/json"
  name         = "AmazonImageTextImageWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageTextImageWriteRequest.json", {})
}


resource "aws_api_gateway_model" "bedrock_amazon_text_write_request" {
  content_type = "application/json"
  name         = "AmazonTextWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonTextWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_text_write_response" {
  content_type = "application/json"
  name         = "AmazonTextWriteResponse"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonTextWriteResponse.json", {})
}
