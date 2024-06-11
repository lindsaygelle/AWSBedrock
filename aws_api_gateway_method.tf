resource "aws_api_gateway_method" "model_get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.model.id
  rest_api_id   = aws_api_gateway_resource.model.rest_api_id
}
