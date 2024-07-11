resource "aws_api_gateway_integration_response" "bedrock_amazon_titan_image_generator_v1_text_image_post_200" {
  http_method         = aws_api_gateway_integration.bedrock_amazon_titan_image_generator_v1_text_image_post.http_method
  resource_id         = aws_api_gateway_integration.bedrock_amazon_titan_image_generator_v1_text_image_post.resource_id
  rest_api_id         = aws_api_gateway_integration.bedrock_amazon_titan_image_generator_v1_text_image_post.rest_api_id
  status_code         = 200
  response_parameters = null
  response_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/response_template/WriteAmazonTitanImageGeneratorV1TextImage200.vtl", {})
  }
}
