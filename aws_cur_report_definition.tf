/*
resource "aws_cur_report_definition" "hourly" {
  report_name                = "hourly"
  time_unit                  = "HOURLY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES", "SPLIT_COST_ALLOCATION_DATA"]
  s3_bucket                  = "example-bucket-name"
  s3_region                  = "us-east-1"
  additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]
}
*/
