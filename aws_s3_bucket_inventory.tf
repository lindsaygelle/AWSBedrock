resource "aws_s3_bucket_inventory" "analytics" {
  bucket = aws_s3_bucket.analytics.bucket
  destination {
    bucket {
      account_id = data.aws_caller_identity.main.account_id
      bucket_arn = aws_s3_bucket.inventory.arn
      format     = "CSV"
      prefix     = null
    }
  }
  enabled                  = true
  included_object_versions = "All"
  name                     = "WEEKLY"
  schedule {
    frequency = "Weekly"
  }
}

resource "aws_s3_bucket_inventory" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.bucket
  destination {
    bucket {
      account_id = data.aws_caller_identity.main.account_id
      bucket_arn = aws_s3_bucket.inventory.arn
      format     = "CSV"
      prefix     = null
    }
  }
  enabled                  = true
  included_object_versions = "All"
  name                     = "WEEKLY"
  schedule {
    frequency = "Weekly"
  }
}

resource "aws_s3_bucket_inventory" "log" {
  bucket = aws_s3_bucket.log.bucket
  destination {
    bucket {
      account_id = data.aws_caller_identity.main.account_id
      bucket_arn = aws_s3_bucket.inventory.arn
      format     = "CSV"
      prefix     = null
    }
  }
  enabled                  = true
  included_object_versions = "All"
  name                     = "WEEKLY"
  schedule {
    frequency = "Weekly"
  }
}

resource "aws_s3_bucket_inventory" "public" {
  bucket = aws_s3_bucket.public.bucket
  destination {
    bucket {
      account_id = data.aws_caller_identity.main.account_id
      bucket_arn = aws_s3_bucket.inventory.arn
      format     = "CSV"
      prefix     = null
    }
  }
  enabled                  = true
  included_object_versions = "All"
  name                     = "WEEKLY"
  schedule {
    frequency = "Weekly"
  }
}
