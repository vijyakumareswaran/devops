terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.57.1"
    }
  }
}

provider "aws" {
  region                      = var.aws_region  # Use a variable for the region
  access_key                  = "test"          # Use dummy values for LocalStack
  secret_key                  = "test"          # Use dummy values for LocalStack
  skip_region_validation      = true            # Skip region validation
  skip_credentials_validation  = true           # Skip credentials validation
  skip_requesting_account_id   = true           # Skip requesting account ID
  endpoints {
    lambda = "http://localhost:4566"           # LocalStack endpoint for Lambda
    iam    = "http://localhost:4566"           # LocalStack endpoint for IAM
    # Add other services here as needed
  }
}