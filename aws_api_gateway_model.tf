resource "aws_api_gateway_model" "text_write_request" {
  content_type = "application/json"
  name         = "TextWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.main.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/TextWriteRequest.json", {})
}
