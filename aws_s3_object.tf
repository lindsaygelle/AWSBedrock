resource "aws_s3_object" "log" {
  acl              = aws_s3_bucket_acl.main.acl
  bucket           = aws_s3_bucket_acl.main.bucket
  content_language = "en-US"
  content_type     = "application/x-directory"
  force_destroy    = true
  key              = "log/"
}
