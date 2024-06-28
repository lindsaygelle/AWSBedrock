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
  rule_version = "CostCategoryExpression.v1"
  tags         = local.tags
}
