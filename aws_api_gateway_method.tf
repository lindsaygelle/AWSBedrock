resource "aws_api_gateway_method" "text_post" {
  api_key_required     = false
  authorization        = "NONE"
  authorization_scopes = null
  http_method          = "POST"
  resource_id          = aws_api_gateway_resource.text.id
  rest_api_id          = aws_api_gateway_resource.text.rest_api_id
  request_models       = null
  request_parameters   = null
  request_validator_id = null
}
