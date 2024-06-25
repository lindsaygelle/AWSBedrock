resource "aws_api_gateway_method" "bedrock_amazon_image_image_variation_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.bedrock_amazon_image_image_variation_write_request.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.bedrock_request_body.id
  resource_id          = aws_api_gateway_resource.bedrock_amazon_image_image_variation.id
  rest_api_id          = aws_api_gateway_resource.bedrock_amazon_image_image_variation.rest_api_id
}

resource "aws_api_gateway_method" "bedrock_amazon_image_inpainting_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.bedrock_amazon_image_inpainting_write_request.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.bedrock_request_body.id
  resource_id          = aws_api_gateway_resource.bedrock_amazon_image_inpainting.id
  rest_api_id          = aws_api_gateway_resource.bedrock_amazon_image_inpainting.rest_api_id
}

resource "aws_api_gateway_method" "bedrock_amazon_image_outpainting_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.bedrock_amazon_image_outpainting_write_request.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.bedrock_request_body.id
  resource_id          = aws_api_gateway_resource.bedrock_amazon_image_outpainting.id
  rest_api_id          = aws_api_gateway_resource.bedrock_amazon_image_outpainting.rest_api_id
}

resource "aws_api_gateway_method" "bedrock_amazon_image_text_image_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.bedrock_amazon_image_text_image_write_request.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.bedrock_request_body.id
  resource_id          = aws_api_gateway_resource.bedrock_amazon_image_text_image.id
  rest_api_id          = aws_api_gateway_resource.bedrock_amazon_image_text_image.rest_api_id
}

resource "aws_api_gateway_method" "bedrock_amazon_text_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.bedrock_amazon_text_write_request.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.bedrock_request_body.id
  resource_id          = aws_api_gateway_resource.bedrock_amazon_text.id
  rest_api_id          = aws_api_gateway_resource.bedrock_amazon_text.rest_api_id
}
