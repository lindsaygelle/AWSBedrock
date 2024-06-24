resource "aws_api_gateway_account" "bedrock" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_rest_api_bedrock.arn // API-Gateway-Execution-Logs_{rest-api-id}/{stage_name}
}
