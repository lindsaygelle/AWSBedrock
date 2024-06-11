resource "aws_api_gateway_stage" "main" {
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_rest_api.arn
    format = jsonencode({
      "caller" : "$context.identity.caller",
      "extendedRequestId" : "$context.extendedRequestId",
      "httpMethod" : "$context.httpMethod",
      "ip" : "$context.identity.sourceIp",
      "protocol" : "$context.protocol",
      "requestId" : "$context.requestId",
      "requestTime" : "$context.requestTime",
      "resourcePath" : "$context.resourcePath",
      "responseLength" : "$context.responseLength"
      "status" : "$context.status",
      "user" : "$context.identity.user",
    })
  }
  deployment_id        = aws_api_gateway_deployment.main.id
  description          = null
  rest_api_id          = aws_api_gateway_deployment.main.rest_api_id
  stage_name           = aws_api_gateway_documentation_version.main.version
  variables            = {}
  xray_tracing_enabled = true
}
