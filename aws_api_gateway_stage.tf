resource "aws_api_gateway_stage" "bedrock" {
  /*
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_rest_api_bedrock.arn
    format = jsonencode({
      "accountId" : "$context.accountId",
      "apiId" : "$context.apiId",
      "authorizer" : "$context.authorizer",
      "awsEndpointRequestId" : "$context.awsEndpointRequestId",
      "deploymentId" : "$context.deploymentId",
      "domainName" : "$context.domainName",
      "domainPrefix" : "$context.domainPrefix",
      "error" : "$context.error",
      "extendedRequestId" : "$context.extendedRequestId",
      "httpMethod" : "$context.httpMethod",
      "identity" : "$context.identity",
      "isCanaryRequest" : "$context.isCanaryRequest",
      "path" : "$context.path",
      "protocol" : "$context.protocol",
      "requestId" : "$context.requestId",
      "requestOverride" : "$context.requestOverride",
      "requestTime" : "$context.requestTime",
      "requestTimeEpoch" : "$context.requestTimeEpoch",
      "resourceId" : "$context.resourceId",
      "resourcePath" : "$context.resourcePath",
      "responseOverride" : "$context.responseOverride",
      "stage" : "$context.stage",
      "wafResponseCode" : "$context.wafResponseCode",
      "webaclArn" : "$context.webaclArn",
    })
  }
  */
  deployment_id        = aws_api_gateway_deployment.bedrock.id
  description          = null
  rest_api_id          = aws_api_gateway_deployment.bedrock.rest_api_id
  stage_name           = aws_api_gateway_documentation_version.bedrock.version
  variables            = {}
  xray_tracing_enabled = true
}
