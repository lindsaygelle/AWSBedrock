resource "aws_s3_bucket" "cloudtrail" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-cloudtrail")
  force_destroy       = true
  object_lock_enabled = null
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

resource "aws_s3_bucket" "inventory" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-inventory")
  force_destroy       = true
  object_lock_enabled = null
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

resource "aws_s3_bucket" "log" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-log")
  force_destroy       = true
  object_lock_enabled = null
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

resource "aws_s3_bucket" "main" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}")
  force_destroy       = true
  object_lock_enabled = null
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
