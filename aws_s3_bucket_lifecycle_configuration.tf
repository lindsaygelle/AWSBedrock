resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail" {
  bucket                = aws_s3_bucket_acl.cloudtrail.bucket
  expected_bucket_owner = aws_s3_bucket_acl.cloudtrail.expected_bucket_owner
  rule {
    expiration {
      days = 730
    }
    id     = "GLACIER"
    status = "Enabled"
    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "log" {
  bucket                = aws_s3_bucket_acl.log.bucket
  expected_bucket_owner = aws_s3_bucket_acl.log.expected_bucket_owner
  rule {
    expiration {
      days = 730
    }
    id     = "GLACIER"
    status = "Enabled"
    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }
}
