resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.bucket
  policy = data.aws_iam_policy_document.s3_bucket_cloudtrail.json
}

resource "aws_s3_bucket_policy" "log" {
  bucket = aws_s3_bucket_acl.log.bucket
  policy = data.aws_iam_policy_document.s3_bucket_log.json
}
