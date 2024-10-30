data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/nodejs"
  output_path = local.lambda_zip_name

  depends_on = [
    random_string.r
  ]
}

resource "aws_iam_role" "this" {
  name = "${local.function_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name   = "policy"
    policy = data.aws_iam_policy_document.this.json
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

# Lambda function configuration
# Lambda function configuration
resource "aws_lambda_function" "this" {
  function_name     = local.function_name
  role              = aws_iam_role.this.arn
  handler           = "handler.hello"  # This matches the exported function in handler.js
  runtime           = "nodejs18.x"      # Updated to a suitable version
  filename          = data.archive_file.this.output_path
  source_code_hash  = data.archive_file.this.output_base64sha256

  environment {
    # Set any environment variables your function may need here
    # For example: VARIABLE_NAME = "value"
  }

  memory_size = 128           # Adjust based on the needs of your function
  timeout     = 30            # Adjust based on the needs of your function

  # Optional: Add VPC configuration if your Lambda needs access to resources in a VPC
  # vpc_config {
  #   subnet_ids         = [...]
  #   security_group_ids = [...]
  # }
}
