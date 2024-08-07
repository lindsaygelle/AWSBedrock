resource "aws_s3_bucket_public_access_block" "analytics" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket_acl.analytics.bucket
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket_acl.cloudtrail.bucket
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "inventory" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket_acl.inventory.bucket
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "log" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket_acl.log.bucket
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "public" {
  block_public_acls       = false
  block_public_policy     = false
  bucket                  = aws_s3_bucket_acl.public.bucket
  ignore_public_acls      = false
  restrict_public_buckets = false
}
