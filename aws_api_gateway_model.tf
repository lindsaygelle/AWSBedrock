resource "aws_api_gateway_model" "bedrock_text_write_request" {
  content_type = "application/json"
  name         = "TextWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/TextWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_text_write_response" {
  content_type = "application/json"
  name         = "TextWriteResponse"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/TextWriteResponse.json", {})
}
