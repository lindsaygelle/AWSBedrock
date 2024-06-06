resource "aws_api_gateway_documentation_version" "main" {
  rest_api_id = aws_api_gateway_deployment.main.rest_api_id
  version     = "V_1"
}
