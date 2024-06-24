resource "aws_api_gateway_documentation_version" "bedrock" {
  depends_on  = [aws_api_gateway_documentation_part.bedrock_api]
  rest_api_id = aws_api_gateway_deployment.bedrock.rest_api_id
  version     = terraform.workspace
}
