resource "aws_api_gateway_resource" "model" {
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "model"
  rest_api_id = aws_api_gateway_rest_api.main.id
}
