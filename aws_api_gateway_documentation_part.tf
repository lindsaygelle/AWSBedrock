resource "aws_api_gateway_documentation_part" "api" {
  location {
    type = "API"
  }
  properties  = jsonencode({})
  rest_api_id = aws_api_gateway_deployment.main.rest_api_id
}
