resource "aws_api_gateway_integration_response" "text_post_200" {
  http_method         = aws_api_gateway_method_response.text_post_200.http_method
  resource_id         = aws_api_gateway_method_response.text_post_200.resource_id
  rest_api_id         = aws_api_gateway_method_response.text_post_200.rest_api_id
  status_code         = aws_api_gateway_method_response.text_post_200.status_code
  response_parameters = null
  response_templates  = null
}
