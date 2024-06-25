resource "aws_api_gateway_resource" "bedrock_amazon" {
  parent_id   = aws_api_gateway_rest_api.bedrock.root_resource_id
  path_part   = "amazon"
  rest_api_id = aws_api_gateway_rest_api.bedrock.id
}

resource "aws_api_gateway_resource" "bedrock_amazon_image" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon.id
  path_part   = "image"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_image_image_variation" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon_image.id
  path_part   = "image_variation"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon_image.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_image_inpainting" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon_image.id
  path_part   = "inpainting"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon_image.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_image_outpainting" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon_image.id
  path_part   = "outpainting"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon_image.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_image_text_image" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon_image.id
  path_part   = "text_image"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon_image.rest_api_id
}

resource "aws_api_gateway_resource" "bedrock_amazon_text" {
  parent_id   = aws_api_gateway_resource.bedrock_amazon.id
  path_part   = "text"
  rest_api_id = aws_api_gateway_resource.bedrock_amazon.rest_api_id
}
