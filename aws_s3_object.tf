resource "aws_s3_object" "public_amazon" {
  acl                           = aws_s3_bucket_acl.public.acl
  key                           = "${aws_api_gateway_resource.bedrock_amazon.path_part}/"
  bucket                        = aws_s3_bucket_public_access_block.public.bucket
  bucket_key_enabled            = true
  cache_control                 = null
  checksum_algorithm            = null
  content_base64                = null
  content_disposition           = null
  content_encoding              = null
  content_language              = "en-US"
  content_type                  = "application/x-directory"
  content                       = null
  etag                          = null
  force_destroy                 = true
  kms_key_id                    = null
  metadata                      = null
  object_lock_legal_hold_status = null
  object_lock_mode              = null
  object_lock_retain_until_date = null
  server_side_encryption        = "AES256"
  source_hash                   = null
  source                        = null
  storage_class                 = "STANDARD"
  tags                          = null
  website_redirect              = null
}

resource "aws_s3_object" "public_amazon_image" {
  acl                           = aws_s3_object.public_amazon.acl
  key                           = "${aws_s3_object.public_amazon.key}${aws_api_gateway_resource.bedrock_amazon_image.path_part}/"
  bucket                        = aws_s3_object.public_amazon.bucket
  bucket_key_enabled            = true
  cache_control                 = null
  checksum_algorithm            = null
  content_base64                = null
  content_disposition           = null
  content_encoding              = null
  content_language              = aws_s3_object.public_amazon.content_language
  content_type                  = "application/x-directory"
  content                       = null
  etag                          = null
  force_destroy                 = aws_s3_object.public_amazon.force_destroy
  kms_key_id                    = null
  metadata                      = null
  object_lock_legal_hold_status = null
  object_lock_mode              = null
  object_lock_retain_until_date = null
  server_side_encryption        = aws_s3_object.public_amazon.server_side_encryption
  source_hash                   = null
  source                        = null
  storage_class                 = aws_s3_object.public_amazon.storage_class
  tags                          = null
  website_redirect              = null
}

resource "aws_s3_object" "public_amazon_image_text_image" {
  acl                           = aws_s3_object.public_amazon_image.acl
  key                           = "${aws_s3_object.public_amazon_image.key}${aws_api_gateway_resource.bedrock_amazon_image_text_image.path_part}/"
  bucket                        = aws_s3_object.public_amazon_image.bucket
  bucket_key_enabled            = true
  cache_control                 = null
  checksum_algorithm            = null
  content_base64                = null
  content_disposition           = null
  content_encoding              = null
  content_language              = aws_s3_object.public_amazon_image.content_language
  content_type                  = "application/x-directory"
  content                       = null
  etag                          = null
  force_destroy                 = aws_s3_object.public_amazon_image.force_destroy
  kms_key_id                    = null
  metadata                      = null
  object_lock_legal_hold_status = null
  object_lock_mode              = null
  object_lock_retain_until_date = null
  server_side_encryption        = aws_s3_object.public_amazon_image.server_side_encryption
  source_hash                   = null
  source                        = null
  storage_class                 = aws_s3_object.public_amazon_image.storage_class
  tags                          = null
  website_redirect              = null
}
