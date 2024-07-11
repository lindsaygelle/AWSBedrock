resource "aws_api_gateway_resource" "bedrock_amazon" {
  parent_id   = aws_api_gateway_rest_api.bedrock.root_resource_id
  path_part   = "amazon"
  rest_api_id = aws_api_gateway_rest_api.bedrock.id
}

resource "aws_api_gateway_resource" "bedrock_amazon_titan" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon.id
  path_part   = "titan"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_titan_image_generator_v1" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon_titan.id
  path_part   = "image_generator_v1"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon_titan.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_titan_image_generator_v1_text_image" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon_titan_image_generator_v1.id
  path_part   = "text_image"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon_titan_image_generator_v1.rest_api_id
}
