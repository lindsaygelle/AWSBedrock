resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail" {
  bucket                = aws_s3_bucket_acl.cloudtrail.bucket
  expected_bucket_owner = aws_s3_bucket_acl.cloudtrail.expected_bucket_owner

  rule {
    id     = "STANDARD_IA"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  rule {
    id     = "INTELLIGENT_TIERING"
    status = "Enabled"
    transition {
      days          = 90
      storage_class = "INTELLIGENT_TIERING"
    }
  }

  rule {
    id     = "GLACIER_IR"
    status = "Enabled"
    transition {
      days          = 180
      storage_class = "GLACIER_IR"
    }
  }

  rule {
    id     = "GLACIER"
    status = "Enabled"
    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "EXPIRE"
    status = "Enabled"
    expiration {
      days = 730
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "inventory" {
  bucket                = aws_s3_bucket_acl.inventory.bucket
  expected_bucket_owner = aws_s3_bucket_acl.inventory.expected_bucket_owner

  rule {
    id     = "STANDARD_IA"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  rule {
    id     = "INTELLIGENT_TIERING"
    status = "Enabled"
    transition {
      days          = 90
      storage_class = "INTELLIGENT_TIERING"
    }
  }

  rule {
    id     = "GLACIER_IR"
    status = "Enabled"
    transition {
      days          = 180
      storage_class = "GLACIER_IR"
    }
  }

  rule {
    id     = "GLACIER"
    status = "Enabled"
    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "EXPIRE"
    status = "Enabled"
    expiration {
      days = 730
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "log" {
  bucket                = aws_s3_bucket_acl.log.bucket
  expected_bucket_owner = aws_s3_bucket_acl.log.expected_bucket_owner

  rule {
    id     = "STANDARD_IA"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  rule {
    id     = "INTELLIGENT_TIERING"
    status = "Enabled"
    transition {
      days          = 90
      storage_class = "INTELLIGENT_TIERING"
    }
  }

  rule {
    id     = "GLACIER_IR"
    status = "Enabled"
    transition {
      days          = 180
      storage_class = "GLACIER_IR"
    }
  }

  rule {
    id     = "GLACIER"
    status = "Enabled"
    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "EXPIRE"
    status = "Enabled"
    expiration {
      days = 730
    }
  }
}
