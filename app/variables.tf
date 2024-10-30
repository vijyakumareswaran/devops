# ---------------------
# API GATEWAY
# ---------------------
variable "stage" {
  description = "API Gateway Stage, default to `test`."
  type        = string
  default     = "test"
}

variable "api_domain_name" {
  type        = string
  description = "DNS domain in the AWS account which you own or is linked via NS records to a DNS zone you own, default to `helloworld.myapp.earth`."
  default     = "helloworld.myapp.earth"
}

# ---------------------
# LAMBDA FUNCTIONS
# ---------------------
variable "runtime" {
  type    = string
  default = "nodejs18.x"
}

variable "architectures" {
  type    = list(string)
  default = ["x86_64"]
}

variable "package_type" {
  type    = string
  default = "Zip"
}

variable "handler" {
  type    = string
  default = "handler.hello"
}

variable "memory_size" {
  type    = number
  default = 128
}

# ---------------------
# GENERAL USE
# ---------------------
variable "name" {
  description = "The string that is used in the `name` filed or equivalent in most resources."
  type        = string
  default     = "helloworld-localstack"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "ap-southeast-1"  # Set your default region
}
