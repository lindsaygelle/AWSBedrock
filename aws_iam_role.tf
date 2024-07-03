resource "aws_iam_role" "api_gateway_rest_api_bedrock" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_api_gateway_bedrock.json
  name               = "${title(local.organization)}APIGatewayRESTAPIBedrock"
  path               = "/${local.organization}/"
  tags               = local.tags
}

resource "aws_iam_role" "lambda_function_bedrock_amazon_image_text_image" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda_function_bedrock_amazon_image_text_image.json
  name               = "${title(local.organization)}LambdaFunctionBedrockAmazonImageTextImage"
  path               = "/${local.organization}/"
  tags               = local.tags
}

resource "aws_iam_role" "sfn_state_machine_bedrock_amazon_image_text_image" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_sfn_state_machine_bedrock_amazon_image_text_image.json
  name               = "${title(local.organization)}SFNStateMachineBedrockAmazonImageTextImage"
  path               = "/${local.organization}/"
  tags               = local.tags
}

resource "aws_iam_role" "sfn_state_machine_bedrock_amazon_text" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_sfn_state_machine_bedrock_amazon_text.json
  name               = "${title(local.organization)}SFNStateMachineBedrockAmazonText"
  path               = "/${local.organization}/"
  tags               = local.tags
}
