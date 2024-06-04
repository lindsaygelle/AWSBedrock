resource "aws_s3_bucket_policy" "logging" {
  bucket = aws_s3_bucket_logging.main.bucket
  policy = data.aws_iam_policy_document.s3_bucket_logging.json
}
