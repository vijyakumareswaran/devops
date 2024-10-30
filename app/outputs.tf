output "lambda" {
  value = aws_lambda_function.this
}

output "api_gateway_url" {
  value = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.this.id}/${var.stage}/"
}
