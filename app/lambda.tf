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

resource "aws_iam_role_policy" "this" {
  name   = "${local.function_name}-lambda-policy"
  role   = aws_iam_role.this.id

  policy = data.aws_iam_policy_document.this.json
}

resource "aws_lambda_function" "this" {
  function_name     = local.function_name
  role              = aws_iam_role.this.arn
  handler           = "handler.hello"
  runtime           = "nodejs18.x"
  filename          = data.archive_file.this.output_path
  source_code_hash  = data.archive_file.this.output_base64sha256

  environment {
    # Set any environment variables your function may need here
  }

  memory_size = 128
  timeout     = 30
}
