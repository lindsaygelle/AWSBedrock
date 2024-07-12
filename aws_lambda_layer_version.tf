resource "aws_lambda_layer_version" "bedrock" {
  compatible_architectures = ["arm64", "x86_64"]
  compatible_runtimes      = ["python3.10"]
  description              = null
  filename                 = data.archive_file.lambda_layer_bedrock.output_path
  layer_name               = "Bedrock"
  skip_destroy             = false
  source_code_hash         = filebase64sha256(data.archive_file.lambda_layer_bedrock.output_path)
}

resource "aws_lambda_layer_version" "s3" {
  compatible_architectures = ["arm64", "x86_64"]
  compatible_runtimes      = ["python3.10"]
  description              = null
  filename                 = data.archive_file.lambda_layer_s3.output_path
  layer_name               = "S3"
  skip_destroy             = false
  source_code_hash         = filebase64sha256(data.archive_file.lambda_layer_s3.output_path)
}

resource "aws_lambda_layer_version" "titan" {
  compatible_architectures = ["arm64", "x86_64"]
  compatible_runtimes      = ["python3.10"]
  description              = null
  filename                 = data.archive_file.lambda_layer_titan.output_path
  layer_name               = "Titan"
  skip_destroy             = false
  source_code_hash         = filebase64sha256(data.archive_file.lambda_layer_titan.output_path)
}
