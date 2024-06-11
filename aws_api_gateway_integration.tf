resource "aws_api_gateway_integration" "model_get" {
  http_method = aws_api_gateway_method.model_get.http_method
  rest_api_id = aws_api_gateway_method.model_get.rest_api_id
  resource_id = aws_api_gateway_method.model_get.resource_id
  type        = "MOCK"
}
