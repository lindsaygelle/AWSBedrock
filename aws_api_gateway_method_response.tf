resource "aws_api_gateway_method_response" "text_post_200" {
  http_method = aws_api_gateway_integration.text_post.http_method
  resource_id = aws_api_gateway_integration.text_post.resource_id
  rest_api_id = aws_api_gateway_integration.text_post.rest_api_id
  status_code = 200
}
