resource "aws_iam_role_policy" "api_gateway_rest_api" {
  policy = data.aws_iam_policy_document.api_gateway_rest_api.json
  role   = aws_iam_role.api_gateway_rest_api.id
}
