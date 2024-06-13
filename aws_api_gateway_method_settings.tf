resource "aws_api_gateway_method_settings" "main" {
  method_path = "*/*"
  rest_api_id = aws_api_gateway_stage.main.rest_api_id
  settings {
    data_trace_enabled = true
    logging_level      = "INFO"
    metrics_enabled    = true
  }
  stage_name = aws_api_gateway_stage.main.stage_name
}
