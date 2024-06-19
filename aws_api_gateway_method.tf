resource "aws_api_gateway_method" "text_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorizer_id        = null
  authorization_scopes = null
  http_method          = "POST"
  request_models = {
    "application/json" = aws_api_gateway_model.text_write_request.name
  }
  request_parameters   = null
  request_validator_id = aws_api_gateway_request_validator.validate_request_body.id
  resource_id          = aws_api_gateway_resource.text.id
  rest_api_id          = aws_api_gateway_resource.text.rest_api_id
}
