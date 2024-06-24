resource "aws_api_gateway_resource" "bedrock_text" {
  parent_id   = aws_api_gateway_rest_api.bedrock.root_resource_id
  path_part   = "text"
  rest_api_id = aws_api_gateway_rest_api.bedrock.id
}
