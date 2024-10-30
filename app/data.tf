data "aws_caller_identity" "this" {
  provider = aws.localstack  # Use a custom provider for LocalStack
}

data "aws_region" "this" {
  provider = aws.localstack  # Use a custom provider for LocalStack
}