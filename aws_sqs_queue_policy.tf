resource "aws_sqs_queue_policy" "api_gateway_rest_api" {
  policy    = data.aws_iam_policy_document.sqs_queue_api_gateway_rest_api.json
  queue_url = aws_sqs_queue.api_gateway_rest_api.id
}
