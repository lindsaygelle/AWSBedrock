
resource "aws_cloudtrail" "main" {
  depends_on                    = [aws_s3_bucket_policy.cloudtrail]
  enable_log_file_validation    = true
  enable_logging                = true
  include_global_service_events = false
  is_multi_region_trail         = false
  name                          = local.organization
  s3_bucket_name                = aws_s3_bucket.cloudtrail.bucket
  s3_key_prefix                 = null
  tags = {
    bucket_arn                   = aws_s3_bucket.cloudtrail.arn
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
