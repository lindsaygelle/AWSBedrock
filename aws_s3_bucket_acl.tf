resource "aws_s3_bucket_acl" "main" {
  acl                   = "private"
  bucket                = aws_s3_bucket_ownership_controls.main.bucket
  expected_bucket_owner = data.aws_caller_identity.main.account_id
}
