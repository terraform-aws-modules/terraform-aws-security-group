provider "aws" {
  version = ">= 2.6.0"
  region  = "${var.region}"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    apigateway     = "http://${var.aws_host}:4566"
    cloudformation = "http://${var.aws_host}:4566"
    cloudwatch     = "http://${var.aws_host}:4566"
    dynamodb       = "http://${var.aws_host}:4566"
    ec2            = "http://${var.aws_host}:4566"
    es             = "http://${var.aws_host}:4566"
    firehose       = "http://${var.aws_host}:4566"
    iam            = "http://${var.aws_host}:4566"
    kinesis        = "http://${var.aws_host}:4566"
    lambda         = "http://${var.aws_host}:4566"
    route53        = "http://${var.aws_host}:4566"
    redshift       = "http://${var.aws_host}:4566"
    s3             = "http://${var.aws_host}:4566"
    secretsmanager = "http://${var.aws_host}:4566"
    ses            = "http://${var.aws_host}:4566"
    sns            = "http://${var.aws_host}:4566"
    sqs            = "http://${var.aws_host}:4566"
    ssm            = "http://${var.aws_host}:4566"
    stepfunctions  = "http://${var.aws_host}:4566"
    sts            = "http://${var.aws_host}:4566"
  }
}
