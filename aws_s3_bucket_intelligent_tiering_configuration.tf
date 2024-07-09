resource "aws_s3_bucket_intelligent_tiering_configuration" "public" {
  bucket = aws_s3_bucket_acl.public.bucket
  name   = "ALL"
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 90
  }
  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
}
