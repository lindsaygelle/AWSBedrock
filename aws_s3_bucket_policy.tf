resource "aws_s3_bucket_policy" "analytics" {
  bucket = aws_s3_bucket_acl.analytics.bucket
  policy = data.aws_iam_policy_document.s3_bucket_analytics.json
}
resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket_acl.cloudtrail.bucket
  policy = data.aws_iam_policy_document.s3_bucket_cloudtrail.json
}

resource "aws_s3_bucket_policy" "inventory" {
  bucket = aws_s3_bucket_acl.inventory.bucket
  policy = data.aws_iam_policy_document.s3_bucket_inventory.json
}

resource "aws_s3_bucket_policy" "log" {
  bucket = aws_s3_bucket_acl.log.bucket
  policy = data.aws_iam_policy_document.s3_bucket_log.json
}
