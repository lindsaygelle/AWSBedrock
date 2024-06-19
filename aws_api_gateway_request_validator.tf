resource "aws_api_gateway_request_validator" "validate_request_body" {
  name                        = "ValidateRequestBody"
  rest_api_id                 = aws_api_gateway_rest_api.main.id
  validate_request_body       = true
  validate_request_parameters = false
}
