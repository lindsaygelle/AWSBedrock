resource "aws_s3_bucket_versioning" "analytics" {
  bucket = aws_s3_bucket_acl.analytics.bucket
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_versioning" "cloudtrail" {
  bucket = aws_s3_bucket_acl.cloudtrail.bucket
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_versioning" "inventory" {
  bucket = aws_s3_bucket_acl.inventory.bucket
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_versioning" "log" {
  bucket = aws_s3_bucket_acl.log.bucket
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_versioning" "public" {
  bucket = aws_s3_bucket_acl.public.bucket
  versioning_configuration {
    status = "Disabled"
  }
}
