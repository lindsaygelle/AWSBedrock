resource "aws_api_gateway_model" "bedrock_amazon_image_image_variation_write_request" {
  content_type = "application/json"
  name         = "AmazonImageImageVariationWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageImageVariationWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_inpainting_write_request" {
  content_type = "application/json"
  name         = "AmazonImageInpaintingWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageInpaintingWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_outpainting_write_request" {
  content_type = "application/json"
  name         = "AmazonImageOutpaintingWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageOutpaintingWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_image_text_image_write_request" {
  content_type = "application/json"
  name         = "AmazonImageTextImageWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonImageTextImageWriteRequest.json", {})
}


resource "aws_api_gateway_model" "bedrock_amazon_text_write_request" {
  content_type = "application/json"
  name         = "AmazonTextWriteRequest"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonTextWriteRequest.json", {})
}

resource "aws_api_gateway_model" "bedrock_amazon_text_write_response" {
  content_type = "application/json"
  name         = "AmazonTextWriteResponse"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/AmazonTextWriteResponse.json", {})
}

resource "aws_api_gateway_model" "bedrock_text_write_response" {
  content_type = "application/json"
  name         = "TextWriteResponse"
  rest_api_id  = aws_api_gateway_rest_api.bedrock.id
  schema       = templatefile("./api_gateway/rest_api/bedrock/model/TextWriteResponse.json", {})
}
