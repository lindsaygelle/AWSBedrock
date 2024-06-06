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
  tags = {
    caller_identity_account_arn  = data.aws_caller_identity.main.arn
    caller_identity_account_id   = data.aws_caller_identity.main.account_id
    caller_identity_user_id      = data.aws_caller_identity.main.user_id
    canonical_user_id            = data.aws_canonical_user_id.main.id
    elb_arn                      = data.aws_elb_service_account.main.arn
    organization                 = local.organization
    partition                    = data.aws_partition.main.partition
    partition_dns_suffix         = data.aws_partition.main.dns_suffix
    partition_id                 = data.aws_partition.main.id
    partition_reverse_dns_prefix = data.aws_partition.main.reverse_dns_prefix
    region                       = data.aws_region.main.name
    workspace                    = terraform.workspace
  }
}
