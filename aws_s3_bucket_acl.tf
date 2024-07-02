resource "aws_s3_bucket_acl" "analytics" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.analytics.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}

resource "aws_s3_bucket_acl" "cloudtrail" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.cloudtrail.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}

resource "aws_s3_bucket_acl" "inventory" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.inventory.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}

resource "aws_s3_bucket_acl" "log" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.log.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}

resource "aws_s3_bucket_acl" "main" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.main.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}

resource "aws_s3_bucket_acl" "public" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.public.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}
