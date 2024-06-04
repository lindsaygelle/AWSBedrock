resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket_acl.main.bucket
  versioning_configuration {
    status = "Disabled"
  }
}
