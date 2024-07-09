resource "aws_api_gateway_rest_api" "bedrock" {
  description                  = null
  disable_execute_api_endpoint = false
  endpoint_configuration {
    types            = ["REGIONAL"]
    vpc_endpoint_ids = null
  }
  fail_on_warnings         = false
  minimum_compression_size = null
  name                     = "bedrock"
  tags                     = local.tags
}
