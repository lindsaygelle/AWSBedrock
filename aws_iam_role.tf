resource "aws_iam_role" "api_gateway_rest_api_bedrock" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_api_gateway_bedrock.json
  name               = "APIGatewayRESTAPIBedrock"
  path               = "/${local.organization}/api_gateway/rest_api/"
  tags               = local.tags
}

resource "aws_iam_role" "lambda_function_bedrock_invoke_model_amazon_titan_image_generator" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda_function_bedrock_invoke_model_amazon_titan_image_generator.json
  name               = "LambdaFunctionBedrockInvokeModelAmazonTitanImageGenerator"
  path               = "/${local.organization}/lambda/function/"
  tags               = local.tags
}

resource "aws_iam_role" "sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_sfn_state_machine_bedrock_invoke_model_amazon_titan_image_generator.json
  name               = "SFNStateMachineBedrockInvokeModelAmazonTitanImageGenerator"
  path               = "/${local.organization}/sfn/state_machine/"
  tags               = local.tags
}

resource "aws_iam_role" "sfn_state_machine_bedrock_invoke_model_amazon_titan_text" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_sfn_state_machine_bedrock_invoke_model_amazon_titan_text.json
  name               = "SFNStateMachineBedrockInvokeModelAmazonTitanText"
  path               = "/${local.organization}/sfn/state_machine/"
  tags               = local.tags
}
