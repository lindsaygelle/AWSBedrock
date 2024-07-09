resource "aws_iam_role_policy" "api_gateway_rest_api_bedrock" {
  name   = aws_iam_role.api_gateway_rest_api_bedrock.name
  policy = data.aws_iam_policy_document.api_gateway_rest_api_bedrock.json
  role   = aws_iam_role.api_gateway_rest_api_bedrock.id
}

resource "aws_iam_role_policy" "lambda_function_bedrock_invoke_model_amazon_titan_image_generator" {
  name   = aws_iam_role.lambda_function_bedrock_invoke_model_amazon_titan_image_generator.name
  policy = data.aws_iam_policy_document.lambda_function_bedrock_invoke_model_amazon_titan_image_generator.json
  role   = aws_iam_role.lambda_function_bedrock_invoke_model_amazon_titan_image_generator.id
}

resource "aws_iam_role_policy" "sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator" {
  name   = aws_iam_role.sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator.name
  policy = data.aws_iam_policy_document.sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator.json
  role   = aws_iam_role.sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator.id
}

resource "aws_iam_role_policy" "sfn_state_machine_bedrock_invoke_model_amazon_titan_text" {
  name   = aws_iam_role.sfn_state_machine_bedrock_invoke_model_amazon_titan_text.name
  policy = data.aws_iam_policy_document.sfn_state_machine_bedrock_invoke_model_amazon_titan_text.json
  role   = aws_iam_role.sfn_state_machine_bedrock_invoke_model_amazon_titan_text.id
}
