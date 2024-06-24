resource "aws_lakeformation_resource" "main" {
  arn = aws_s3_bucket.main.arn
}
