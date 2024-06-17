resource "aws_sfn_state_machine" "bedrock_text" {
  definition = templatefile("./step_function/state_machine/BedrockInvokeModelText.json", {
    aws_region = data.aws_region.main.name
  })
  /*
  logging_configuration {
    include_execution_data = true
    level                  = "ALL"
    log_destination        = "${aws_cloudwatch_log_group.sfn_state_machine_bedrock_text.arn}:*"
  }
  */
  name     = "${local.organization}-bedrock-text"
  publish  = false
  role_arn = aws_iam_role.sfn_state_machine_bedrock_text.arn
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
  type = "EXPRESS"
}
