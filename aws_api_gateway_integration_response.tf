resource "aws_api_gateway_integration_response" "bedrock_amazon_image_image_variation_post_200" {
  http_method         = aws_api_gateway_integration.bedrock_amazon_image_image_variation_post.http_method
  resource_id         = aws_api_gateway_integration.bedrock_amazon_image_image_variation_post.resource_id
  rest_api_id         = aws_api_gateway_integration.bedrock_amazon_image_image_variation_post.rest_api_id
  status_code         = 200
  response_parameters = null
  response_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/response_template/AmazonImageImageVariationWriteResponse.vtl", {})
  }
}
resource "aws_api_gateway_integration_response" "bedrock_amazon_image_inpainting_post_200" {
  http_method         = aws_api_gateway_integration.bedrock_amazon_image_inpainting_post.http_method
  resource_id         = aws_api_gateway_integration.bedrock_amazon_image_inpainting_post.resource_id
  rest_api_id         = aws_api_gateway_integration.bedrock_amazon_image_inpainting_post.rest_api_id
  status_code         = 200
  response_parameters = null
  response_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/response_template/AmazonImageInpaintingWriteResponse.vtl", {})
  }
}
resource "aws_api_gateway_integration_response" "bedrock_amazon_image_outpainting_post_200" {
  http_method         = aws_api_gateway_integration.bedrock_amazon_image_outpainting_post.http_method
  resource_id         = aws_api_gateway_integration.bedrock_amazon_image_outpainting_post.resource_id
  rest_api_id         = aws_api_gateway_integration.bedrock_amazon_image_outpainting_post.rest_api_id
  status_code         = 200
  response_parameters = null
  response_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/response_template/AmazonImageOutpaintingWriteResponse.vtl", {})
  }
}
resource "aws_api_gateway_integration_response" "bedrock_amazon_image_text_image_post_200" {
  http_method         = aws_api_gateway_integration.bedrock_amazon_image_text_image_post.http_method
  resource_id         = aws_api_gateway_integration.bedrock_amazon_image_text_image_post.resource_id
  rest_api_id         = aws_api_gateway_integration.bedrock_amazon_image_text_image_post.rest_api_id
  status_code         = 200
  response_parameters = null
  response_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/response_template/AmazonImageTextImageWriteResponse.vtl", {})
  }
}

resource "aws_api_gateway_integration_response" "bedrock_amazon_text_post_200" {
  http_method         = aws_api_gateway_integration.bedrock_amazon_text_post.http_method
  resource_id         = aws_api_gateway_integration.bedrock_amazon_text_post.resource_id
  rest_api_id         = aws_api_gateway_integration.bedrock_amazon_text_post.rest_api_id
  status_code         = 200
  response_parameters = null
  response_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/response_template/AmazonTextWriteResponse.vtl", {})
  }
}
