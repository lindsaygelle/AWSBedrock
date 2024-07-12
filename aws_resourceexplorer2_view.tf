resource "aws_resourceexplorer2_view" "api_gateway_rest_api" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:apigateway:restapis tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "api-gateway-rest-api"
}

resource "aws_resourceexplorer2_view" "cloudtrail_trail" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:cloudtrail:trail tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "cloudtrail-trail"
}

resource "aws_resourceexplorer2_view" "cloudwatch_log_group" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:logs:log-group tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "cloudwatch-log-group"
}

resource "aws_resourceexplorer2_view" "iam" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:iam:* tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "iam"
}

resource "aws_resourceexplorer2_view" "lambda_function" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:lambda:function tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "lambda-function"
}

resource "aws_resourceexplorer2_view" "lambda_layer" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:lambda:layer"
  }
  name = "lambda-layer"
}

resource "aws_resourceexplorer2_view" "s3_bucket" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:s3:bucket tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "s3-bucket"
}

resource "aws_resourceexplorer2_view" "sfn_step_function" {
  depends_on = [aws_resourceexplorer2_index.main]
  filters {
    filter_string = "region:${data.aws_region.main.name} resourcetype:states:stateMachine tag:organization=${local.organization}"
  }
  included_property {
    name = "tags"
  }
  name = "sfn-step-function"
}
