resource "aws_api_gateway_deployment" "main" {
  description = null
  lifecycle {
    create_before_destroy = true
  }
  rest_api_id = aws_api_gateway_rest_api.main.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.text,
      aws_api_gateway_method.text_post,
      aws_api_gateway_integration.text_post,
      aws_api_gateway_method_response.text_post_200,
      aws_api_gateway_integration_response.text_post_200,
    ]))
  }
}
