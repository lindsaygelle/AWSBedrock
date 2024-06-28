
resource "aws_cloudtrail" "main" {
  depends_on                    = [aws_s3_bucket_policy.cloudtrail]
  enable_log_file_validation    = true
  enable_logging                = true
  include_global_service_events = false
  is_multi_region_trail         = false
  name                          = local.organization
  s3_bucket_name                = aws_s3_bucket.cloudtrail.bucket
  s3_key_prefix                 = null
  tags                          = local.tags
}
