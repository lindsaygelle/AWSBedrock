resource "aws_cloudwatch_log_group" "api_gateway_rest_api" {
  log_group_class   = "STANDARD"
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.main.id}"
  retention_in_days = 7
  skip_destroy      = false
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
    resource                     = "API_GATEWAY"
    resource_arn                 = aws_api_gateway_rest_api.main.arn
    workspace                    = terraform.workspace
  }
}
