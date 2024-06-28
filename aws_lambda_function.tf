resource "aws_lambda_function" "bedrock_amazon_titan_image" {
  architectures           = ["x86_64"]
  code_signing_config_arn = null
  description             = null
  environment {

  }
  ephemeral_storage {
    size = 512
  }
  filename      = data.archive_file.lambda_function_bedrock_amazon_titan_image.output_path
  function_name = "${local.organization}-bedrock-amazon-titan-image"
  handler       = "main"
  image_uri     = null
  kms_key_arn   = null
  layers        = []
  logging_config {
    application_log_level = "INFO"
    log_format            = "JSON"
    log_group             = null
    system_log_level      = "INFO"
  }
  memory_size                        = 128
  package_type                       = "Zip"
  publish                            = false
  reserved_concurrent_executions     = -1
  replace_security_groups_on_destroy = null
  replacement_security_group_ids     = null
  role                               = aws_iam_role.lambda_function_bedrock_amazon_titan_image.arn
  runtime                            = "python3.10"
  s3_bucket                          = null
  s3_key                             = null
  s3_object_version                  = null
  skip_destroy                       = false
  source_code_hash                   = filebase64sha256(data.archive_file.lambda_function_bedrock_amazon_titan_image.output_path)
  tags                               = local.tags
  timeout                            = 10
  tracing_config {
    mode = "PassThrough"
  }
}
