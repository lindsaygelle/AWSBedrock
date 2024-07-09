resource "aws_s3_bucket" "analytics" {
  bucket              = lower("${local.organization}-analytics")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket              = lower("${local.organization}-cloudtrail")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "inventory" {
  bucket              = lower("${local.organization}-inventory")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "log" {
  bucket              = lower("${local.organization}-log")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}

resource "aws_s3_bucket" "public" {
  bucket              = lower("${local.organization}-public")
  force_destroy       = true
  object_lock_enabled = null
  tags                = local.tags
}
