resource "aws_api_gateway_deployment" "main" {
  description = null
  lifecycle {
    create_before_destroy = true
  }
  rest_api_id = aws_api_gateway_rest_api.main.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.model,
      aws_api_gateway_method.model_get,
      aws_api_gateway_integration.model_get,
    ]))
  }
}
