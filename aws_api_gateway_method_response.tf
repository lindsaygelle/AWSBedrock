resource "aws_api_gateway_method_response" "bedrock_amazon_text_post_200" {
  http_method = aws_api_gateway_integration_response.bedrock_amazon_text_post_200.http_method
  resource_id = aws_api_gateway_integration_response.bedrock_amazon_text_post_200.resource_id
  response_models = {
    "application/json" = aws_api_gateway_model.bedrock_amazon_text_write_response.name
  }
  rest_api_id = aws_api_gateway_integration_response.bedrock_amazon_text_post_200.rest_api_id
  status_code = aws_api_gateway_integration_response.bedrock_amazon_text_post_200.status_code
}
