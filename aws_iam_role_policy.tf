resource "aws_iam_role_policy" "api_gateway_rest_api_bedrock" {
  name   = aws_iam_role.api_gateway_rest_api_bedrock.name
  policy = data.aws_iam_policy_document.api_gateway_rest_api_bedrock.json
  role   = aws_iam_role.api_gateway_rest_api_bedrock.id
}

resource "aws_iam_role_policy" "lambda_function_bedrock_amazon_image" {
  name   = aws_iam_role.lambda_function_bedrock_amazon_image.name
  policy = data.aws_iam_policy_document.lambda_function_bedrock_amazon_image.json
  role   = aws_iam_role.lambda_function_bedrock_amazon_image.id
}

resource "aws_iam_role_policy" "sfn_state_machine_bedrock_amazon_image_text_image" {
  name   = aws_iam_role.sfn_state_machine_bedrock_amazon_image_text_image.name
  policy = data.aws_iam_policy_document.sfn_state_machine_bedrock_amazon_image_text_image.json
  role   = aws_iam_role.sfn_state_machine_bedrock_amazon_image_text_image.id
}

resource "aws_iam_role_policy" "sfn_state_machine_bedrock_amazon_text" {
  name   = aws_iam_role.sfn_state_machine_bedrock_amazon_text.name
  policy = data.aws_iam_policy_document.sfn_state_machine_bedrock_amazon_text.json
  role   = aws_iam_role.sfn_state_machine_bedrock_amazon_text.id
}
