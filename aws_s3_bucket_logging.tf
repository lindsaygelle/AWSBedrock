resource "aws_s3_bucket_logging" "cloudtrail" {
  bucket                = aws_s3_bucket_acl.cloudtrail.bucket
  expected_bucket_owner = aws_s3_bucket_acl.cloudtrail.expected_bucket_owner
  target_bucket         = aws_s3_bucket_acl.log.bucket
  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
  target_prefix = ""
}

resource "aws_s3_bucket_logging" "inventory" {
  bucket                = aws_s3_bucket_acl.inventory.bucket
  expected_bucket_owner = aws_s3_bucket_acl.inventory.expected_bucket_owner
  target_bucket         = aws_s3_bucket_acl.log.bucket
  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
  target_prefix = ""
}

resource "aws_s3_bucket_logging" "main" {
  bucket                = aws_s3_bucket_acl.main.bucket
  expected_bucket_owner = aws_s3_bucket_acl.main.expected_bucket_owner
  target_bucket         = aws_s3_bucket_acl.log.bucket
  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
  target_prefix = ""
}
