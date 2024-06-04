variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "organization" {
  default = null
  type    = string
}

variable "random_pet" {
  default = 1
  type    = number
}
