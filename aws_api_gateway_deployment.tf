resource "aws_api_gateway_deployment" "bedrock" {
  description = null
  lifecycle {
    create_before_destroy = true
  }
  rest_api_id = aws_api_gateway_rest_api.bedrock.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_request_validator.bedrock_request_body,
      aws_api_gateway_model.bedrock_text_write_request,
      aws_api_gateway_model.bedrock_text_write_response,
      aws_api_gateway_resource.bedrock_text,
      aws_api_gateway_method.bedrock_text_post,
      aws_api_gateway_integration.bedrock_text_post,
      aws_api_gateway_integration_response.bedrock_text_post_200,
      aws_api_gateway_method_response.bedrock_text_post_200,
    ]))
  }
}
