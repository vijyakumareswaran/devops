provider "aws" {
  alias                       = "localstack"
  region                      = "ap-southeast-1"
  access_key                  = "test"
  secret_access_key          = "test"
  endpoint                   = "http://localhost:4566"
  skip_credentials_validation = true
  skip_get_ec2_platforms     = true
}

data "aws_caller_identity" "this" {
  provider = aws.localstack
}

data "aws_region" "this" {
  provider = aws.localstack
}
