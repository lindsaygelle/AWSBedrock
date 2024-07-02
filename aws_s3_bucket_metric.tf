resource "aws_s3_bucket_metric" "analytics" {
  bucket = aws_s3_bucket_acl.analytics.bucket
  name   = "ALL"
}

resource "aws_s3_bucket_metric" "cloudtrail" {
  bucket = aws_s3_bucket_acl.cloudtrail.bucket
  name   = "ALL"
}

resource "aws_s3_bucket_metric" "inventory" {
  bucket = aws_s3_bucket_acl.inventory.bucket
  name   = "ALL"
}

resource "aws_s3_bucket_metric" "log" {
  bucket = aws_s3_bucket_acl.log.bucket
  name   = "ALL"
}

resource "aws_s3_bucket_metric" "main" {
  bucket = aws_s3_bucket_acl.main.bucket
  name   = "ALL"
}

resource "aws_s3_bucket_metric" "public" {
  bucket = aws_s3_bucket_acl.public.bucket
  name   = "ALL"
}
