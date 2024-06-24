resource "aws_api_gateway_request_validator" "bedrock_request_body" {
  name                        = "RequestBody"
  rest_api_id                 = aws_api_gateway_rest_api.bedrock.id
  validate_request_body       = true
  validate_request_parameters = false
}
