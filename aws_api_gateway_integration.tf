resource "aws_api_gateway_integration" "bedrock_amazon_image_image_variation_post" {
  credentials             = aws_iam_role.api_gateway_rest_api_bedrock.arn
  http_method             = aws_api_gateway_method.bedrock_amazon_image_image_variation_post.http_method
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates       = null
  resource_id             = aws_api_gateway_method.bedrock_amazon_image_image_variation_post.resource_id
  rest_api_id             = aws_api_gateway_method.bedrock_amazon_image_image_variation_post.rest_api_id
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.main.name}:states:action/StartSyncExecution"
}

resource "aws_api_gateway_integration" "bedrock_amazon_image_inpainting_post" {
  credentials             = aws_iam_role.api_gateway_rest_api_bedrock.arn
  http_method             = aws_api_gateway_method.bedrock_amazon_image_inpainting_post.http_method
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates       = null
  resource_id             = aws_api_gateway_method.bedrock_amazon_image_inpainting_post.resource_id
  rest_api_id             = aws_api_gateway_method.bedrock_amazon_image_inpainting_post.rest_api_id
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.main.name}:states:action/StartSyncExecution"
}

resource "aws_api_gateway_integration" "bedrock_amazon_image_outpainting_post" {
  credentials             = aws_iam_role.api_gateway_rest_api_bedrock.arn
  http_method             = aws_api_gateway_method.bedrock_amazon_image_outpainting_post.http_method
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates       = null
  resource_id             = aws_api_gateway_method.bedrock_amazon_image_outpainting_post.resource_id
  rest_api_id             = aws_api_gateway_method.bedrock_amazon_image_outpainting_post.rest_api_id
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.main.name}:states:action/StartSyncExecution"
}

resource "aws_api_gateway_integration" "bedrock_amazon_image_text_image_post" {
  credentials             = aws_iam_role.api_gateway_rest_api_bedrock.arn
  http_method             = aws_api_gateway_method.bedrock_amazon_image_text_image_post.http_method
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/request_template/AmazonImageTextImageWriteRequest.vtl", {
      aws_sfn_state_machine_arn = aws_sfn_state_machine.bedrock_invoke_model_amazon_titan_image_generator_text_image.arn
    })
  }
  resource_id = aws_api_gateway_method.bedrock_amazon_image_text_image_post.resource_id
  rest_api_id = aws_api_gateway_method.bedrock_amazon_image_text_image_post.rest_api_id
  type        = "AWS"
  uri         = "arn:aws:apigateway:${data.aws_region.main.name}:states:action/StartSyncExecution"
}

resource "aws_api_gateway_integration" "bedrock_amazon_text_post" {
  credentials             = aws_iam_role.api_gateway_rest_api_bedrock.arn
  http_method             = aws_api_gateway_method.bedrock_amazon_text_post.http_method
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates = {
    "application/json" = templatefile("./api_gateway/rest_api/bedrock/request_template/AmazonTextWriteRequest.vtl", {
      aws_sfn_state_machine_arn = aws_sfn_state_machine.bedrock_invoke_model_amazon_titan_text.arn
    })
  }
  resource_id = aws_api_gateway_method.bedrock_amazon_text_post.resource_id
  rest_api_id = aws_api_gateway_method.bedrock_amazon_text_post.rest_api_id
  type        = "AWS"
  uri         = "arn:aws:apigateway:${data.aws_region.main.name}:states:action/StartSyncExecution"
}
