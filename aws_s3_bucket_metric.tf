resource "aws_s3_bucket_metric" "cloudtrail" {
  bucket = aws_s3_bucket_acl.cloudtrail.bucket
  name   = "ALL"
}

resource "aws_s3_bucket_metric" "log" {
  bucket = aws_s3_bucket_acl.log.bucket
  name   = "ALL"
}
