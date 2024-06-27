resource "aws_resourceexplorer2_view" "api_gateway_rest_api" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:apigateway:restapis tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "${local.organization}-api-gateway-rest-api"
}

resource "aws_resourceexplorer2_view" "cloudtrail_trail" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:cloudtrail:trail tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "${local.organization}-cloudtrail-trail"
}

resource "aws_resourceexplorer2_view" "cloudwatch_log_group" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:logs:log-group tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "${local.organization}-cloudwatch-log-group"
}

resource "aws_resourceexplorer2_view" "s3_bucket" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:s3:bucket tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "${local.organization}-s3-bucket"
}

resource "aws_resourceexplorer2_view" "sfn_step_function" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:states:stateMachine tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "${local.organization}-sfn-step-function"
}
