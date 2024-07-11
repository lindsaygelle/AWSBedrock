resource "aws_lambda_function" "write_amazon_titan_image_generator_v1_text_image" {
  architectures           = ["x86_64"]
  code_signing_config_arn = null
  description             = null
  environment {
    variables = {
      S3_BUCKET_ACL   = aws_s3_bucket_acl.public.acl
      S3_BUCKET_NAME  = aws_s3_bucket.public.bucket
      S3_BUCKET_OWNER = aws_s3_bucket_acl.public.expected_bucket_owner
    }
  }
  ephemeral_storage {
    size = 512
  }
  filename                           = data.archive_file.lambda_function_write_amazon_titan_image_generator_v1_text_image.output_path
  function_name                      = "WriteAmazonTitanImageGeneratorV1TextImage"
  handler                            = "main.main"
  image_uri                          = null
  kms_key_arn                        = null
  layers                             = []
  memory_size                        = 128
  package_type                       = "Zip"
  publish                            = false
  reserved_concurrent_executions     = -1
  replace_security_groups_on_destroy = null
  replacement_security_group_ids     = null
  role                               = aws_iam_role.lambda_function_write_amazon_titan_image_generator_v1_text_image.arn
  runtime                            = "python3.10"
  s3_bucket                          = null
  s3_key                             = null
  s3_object_version                  = null
  skip_destroy                       = false
  source_code_hash                   = filebase64sha256(data.archive_file.lambda_function_write_amazon_titan_image_generator_v1_text_image.output_path)
  tags                               = local.tags
  timeout                            = 60 * 5
  tracing_config {
    mode = "PassThrough"
  }
}
