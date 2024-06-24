resource "aws_sqs_queue" "api_gateway_rest_api" {
  delay_seconds             = 0
  fifo_queue                = false
  name                      = "${local.organization}-api-gateway-rest-api"
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0
  tags = {
    caller_identity_account_arn  = data.aws_caller_identity.main.arn
    caller_identity_account_id   = data.aws_caller_identity.main.account_id
    caller_identity_user_id      = data.aws_caller_identity.main.user_id
    canonical_user_id            = data.aws_canonical_user_id.main.id
    elb_arn                      = data.aws_elb_service_account.main.arn
    organization                 = local.organization
    partition                    = data.aws_partition.main.partition
    partition_dns_suffix         = data.aws_partition.main.dns_suffix
    partition_id                 = data.aws_partition.main.id
    partition_reverse_dns_prefix = data.aws_partition.main.reverse_dns_prefix
    region                       = data.aws_region.main.name
    workspace                    = terraform.workspace
  }
  visibility_timeout_seconds = 30
}
