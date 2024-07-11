resource "aws_api_gateway_method" "bedrock_amazon_titan_image_generator_v1_text_image_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.bedrock_write_amazon_titan_image_generator_v1_text_image.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.bedrock_request_body.id
  resource_id          = aws_api_gateway_resource.bedrock_amazon_titan_image_generator_v1_text_image.id
  rest_api_id          = aws_api_gateway_resource.bedrock_amazon_titan_image_generator_v1_text_image.rest_api_id
}
