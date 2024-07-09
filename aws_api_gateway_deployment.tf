resource "aws_api_gateway_deployment" "bedrock" {
  description = null
  lifecycle {
    create_before_destroy = true
  }
  rest_api_id = aws_api_gateway_rest_api.bedrock.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_request_validator.bedrock_request_body,
      aws_api_gateway_model.bedrock_amazon_image_text_image_write_request,
      aws_api_gateway_model.bedrock_amazon_text_write_request,
      aws_api_gateway_model.bedrock_amazon_text_write_response,
      aws_api_gateway_resource.bedrock_amazon,
      aws_api_gateway_resource.bedrock_amazon_image,
      aws_api_gateway_resource.bedrock_amazon_image_text_image,
      aws_api_gateway_resource.bedrock_amazon_text,
      aws_api_gateway_method.bedrock_amazon_image_text_image_post,
      aws_api_gateway_method.bedrock_amazon_text_post,
      aws_api_gateway_integration.bedrock_amazon_image_text_image_post,
      aws_api_gateway_integration.bedrock_amazon_text_post,
      aws_api_gateway_integration_response.bedrock_amazon_text_post_200,
      aws_api_gateway_integration_response.bedrock_amazon_image_text_image_post_200,
      aws_api_gateway_method_response.bedrock_amazon_image_text_image_post_200,
      aws_api_gateway_method_response.bedrock_amazon_text_post_200,
    ]))
  }
}
