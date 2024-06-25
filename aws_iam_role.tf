resource "aws_iam_role" "api_gateway_rest_api_bedrock" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_api_gateway_bedrock.json
  name               = "${title(local.organization)}APIGatewayRESTAPIBedrock"
  path               = "/${local.organization}/"
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
}

resource "aws_iam_role" "sfn_state_machine_bedrock_amazon_image_text_image" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_sfn_state_machine_bedrock_amazon_image_text_image.json
  name               = "${title(local.organization)}SFNStateMachineBedrockAmazonImageTextImage"
  path               = "/${local.organization}/"
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
}

resource "aws_iam_role" "sfn_state_machine_bedrock_amazon_text" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_sfn_state_machine_bedrock_amazon_text.json
  name               = "${title(local.organization)}SFNStateMachineBedrockAmazonText"
  path               = "/${local.organization}/"
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
}
