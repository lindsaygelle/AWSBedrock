resource "aws_ce_cost_category" "main" {
  name = local.organization
  rule {
    type  = "REGULAR"
    value = "S3"
    rule {
      and {
        dimension {
          key           = "REGION"
          values        = [data.aws_region.main.name]
          match_options = ["EQUALS"]
        }
      }
      and {
        dimension {
          key           = "SERVICE_CODE"
          values        = ["AmazonS3"]
          match_options = ["EQUALS"]
        }
      }
    }
  }
  rule {
    type  = "REGULAR"
    value = "APIGateway"
    rule {
      and {
        dimension {
          key           = "REGION"
          values        = [data.aws_region.main.name]
          match_options = ["EQUALS"]
        }
      }
      and {
        dimension {
          key           = "SERVICE_CODE"
          values        = ["AmazonApiGateway"]
          match_options = ["EQUALS"]
        }
      }
    }
  }
  rule {
    type  = "REGULAR"
    value = "Lambda"
    rule {
      and {
        dimension {
          key           = "REGION"
          values        = [data.aws_region.main.name]
          match_options = ["EQUALS"]
        }
      }
      and {
        dimension {
          key           = "SERVICE_CODE"
          values        = ["AWSLambda"]
          match_options = ["EQUALS"]
        }
      }
    }
  }
  rule {
    type  = "REGULAR"
    value = "SFNStepFunction"
    rule {
      and {
        dimension {
          key           = "REGION"
          values        = [data.aws_region.main.name]
          match_options = ["EQUALS"]
        }
      }
      and {
        dimension {
          key           = "SERVICE_CODE"
          values        = ["AmazonStates"]
          match_options = ["EQUALS"]
        }
      }
    }
  }
  rule_version = "CostCategoryExpression.v1"
  tags         = local.tags
}
