resource "aws_api_gateway_integration" "text_post" {
  credentials             = aws_iam_role.api_gateway_rest_api.arn
  http_method             = aws_api_gateway_method.text_post.http_method
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/request_template/TextWriteRequest.vtl", {
      aws_sfn_state_machine_arn = aws_sfn_state_machine.bedrock_text.arn
    })
  }
  resource_id = aws_api_gateway_method.text_post.resource_id
  rest_api_id = aws_api_gateway_method.text_post.rest_api_id
  type        = "AWS"
  uri         = "arn:aws:apigateway:${data.aws_region.main.name}:states:action/StartSyncExecution"
}
