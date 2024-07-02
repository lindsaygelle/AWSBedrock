resource "aws_s3_bucket" "analytics" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-analytics")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-cloudtrail")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "inventory" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-inventory")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "log" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-log")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "main" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "public" {
  bucket              = lower("${data.aws_caller_identity.main.account_id}-${local.organization}-public")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}
