data "aws_caller_identity" "this" {
  provider = aws
}

data "aws_region" "this" {
  provider = aws
}
