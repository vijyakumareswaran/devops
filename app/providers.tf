terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.57.1"
    }
  }
}

provider "aws" {
  region = var.aws_region  # Use a variable for the region
}