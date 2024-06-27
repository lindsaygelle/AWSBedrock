resource "aws_config_aggregate_authorization" "main" {
  account_id = data.aws_caller_identity.main.account_id
  region     = data.aws_region.main.name
}
