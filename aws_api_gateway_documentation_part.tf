/*
resource "aws_api_gateway_documentation_part" "bedrock_api" {
  location {
    type = "API"
  }
  properties  = jsonencode({})
  rest_api_id = aws_api_gateway_deployment.bedrock.rest_api_id
}
*/
