resource "aws_s3_bucket_analytics_configuration" "cloudtrail" {
  bucket = aws_s3_bucket_acl.cloudtrail.bucket
  name   = "ALL"
  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_account_id = data.aws_caller_identity.main.account_id
          bucket_arn        = aws_s3_bucket.analytics.arn
          format            = "CSV"
          prefix            = null
        }
      }
      output_schema_version = "V_1"
    }
  }
}

resource "aws_s3_bucket_analytics_configuration" "inventory" {
  bucket = aws_s3_bucket_acl.inventory.bucket
  name   = "ALL"
  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_account_id = data.aws_caller_identity.main.account_id
          bucket_arn        = aws_s3_bucket.analytics.arn
          format            = "CSV"
          prefix            = null
        }
      }
      output_schema_version = "V_1"
    }
  }
}

resource "aws_s3_bucket_analytics_configuration" "log" {
  bucket = aws_s3_bucket_acl.log.bucket
  name   = "ALL"
  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_account_id = data.aws_caller_identity.main.account_id
          bucket_arn        = aws_s3_bucket.analytics.arn
          format            = "CSV"
          prefix            = null
        }
      }
      output_schema_version = "V_1"
    }
  }
}

resource "aws_s3_bucket_analytics_configuration" "public" {
  bucket = aws_s3_bucket_acl.public.bucket
  name   = "ALL"
  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_account_id = data.aws_caller_identity.main.account_id
          bucket_arn        = aws_s3_bucket.analytics.arn
          format            = "CSV"
          prefix            = null
        }
      }
      output_schema_version = "V_1"
    }
  }
}
